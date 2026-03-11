use std::ffi::OsStr;

use src::{bstr::ByteSlice, config::tree};

pub fn blame_file(
    mut repo: src::Repository,
    file: &OsStr,
    options: src::blame::Options,
    out: impl std::io::Write,
    err: Option<&mut dyn std::io::Write>,
) -> anyhow::Result<()> {
    {
        let mut config = repo.config_snapshot_mut();
        if config.string(&tree::Core::DELTA_BASE_CACHE_LIMIT).is_none() {
            config.set_value(&tree::Core::DELTA_BASE_CACHE_LIMIT, "100m")?;
        }
    }
    let index = repo.index_or_empty()?;
    repo.object_cache_size_if_unset(repo.compute_object_cache_size_for_tree_diffs(&index));

    let file = src::path::os_str_into_bstr(file)?;
    let specs = repo.pathspec(
        false,
        [file],
        true,
        &index,
        src::worktree::stack::state::attributes::Source::WorktreeThenIdMapping.adjust_for_bare(repo.is_bare()),
    )?;
    // TODO: there should be a way to normalize paths without going through patterns, at least in this case maybe?
    //       `Search` actually sorts patterns by excluding or not, all that can lead to strange results.
    let file = specs
        .search()
        .patterns()
        .map(|p| p.path().to_owned())
        .next()
        .expect("exactly one pattern");

    let suspect: src::ObjectId = repo.head()?.into_peeled_id()?.into();
    let cache: Option<src::commitgraph::Graph> = repo.commit_graph_if_enabled()?;
    let mut resource_cache = repo.diff_resource_cache_for_tree_diff()?;
    let outcome = src::blame::file(
        &repo.objects,
        suspect,
        cache,
        &mut resource_cache,
        file.as_bstr(),
        options,
    )?;
    let statistics = outcome.statistics;
    show_blame_entries(out, outcome, file)?;

    if let Some(err) = err {
        writeln!(err, "{statistics:#?}")?;
    }
    Ok(())
}

fn show_blame_entries(
    mut out: impl std::io::Write,
    outcome: src::blame::Outcome,
    source_file_name: src::bstr::BString,
) -> Result<(), std::io::Error> {
    for (entry, lines_in_hunk) in outcome.entries_with_lines() {
        for ((actual_lno, source_lno), line) in entry
            .range_in_blamed_file()
            .zip(entry.range_in_source_file())
            .zip(lines_in_hunk)
        {
            write!(
                out,
                "{short_id} {line_no} ",
                short_id = entry.commit_id.to_hex_with_len(8),
                line_no = actual_lno + 1,
            )?;

            let source_file_name = entry.source_file_name.as_ref().unwrap_or(&source_file_name);
            write!(out, "{source_file_name} ")?;

            write!(out, "{src_line_no} {line}", src_line_no = source_lno + 1)?;
        }
    }

    Ok(())
}
