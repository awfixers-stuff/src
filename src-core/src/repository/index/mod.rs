use std::{ffi::OsString, path::PathBuf};

use anyhow::bail;

pub fn from_tree(
    repo: src::Repository,
    mut spec: OsString,
    index_path: Option<PathBuf>,
    force: bool,
    skip_hash: bool,
) -> anyhow::Result<()> {
    spec.push("^{tree}");
    let spec = src::path::os_str_into_bstr(&spec)?;
    let tree = repo.rev_parse_single(spec)?;

    let mut index = repo.index_from_tree(&tree)?;
    let options = src::index::write::Options {
        skip_hash,
        ..Default::default()
    };

    match index_path {
        Some(index_path) => {
            if index_path.is_file() && !force {
                anyhow::bail!(
                    "File at \"{}\" already exists, to overwrite use the '-f' flag",
                    index_path.display()
                );
            }
            index.set_path(index_path);
            index.write(options)?;
        }
        None => {
            let mut out = Vec::with_capacity(512 * 1024);
            index.write_to(&mut out, options)?;
        }
    }

    Ok(())
}

pub fn from_list(
    entries_file: PathBuf,
    index_path: Option<PathBuf>,
    force: bool,
    skip_hash: bool,
) -> anyhow::Result<()> {
    use std::io::BufRead;
    let object_hash = src::hash::Kind::Sha1;

    let mut index = src::index::State::new(object_hash);
    for path in std::io::BufReader::new(std::fs::File::open(entries_file)?).lines() {
        let path: PathBuf = path?.into();
        #[allow(clippy::unnecessary_debug_formatting)]
        if !path.is_relative() {
            bail!("Input paths need to be relative, but {path:?} is not.")
        }
        let path = src::path::into_bstr(path);
        index.dangerously_push_entry(
            src::index::entry::Stat::default(),
            src::hash::ObjectId::empty_blob(object_hash),
            src::index::entry::Flags::empty(),
            src::index::entry::Mode::FILE,
            src::path::to_unix_separators_on_windows(path).as_ref(),
        );
    }
    index.sort_entries();

    let options = src::index::write::Options {
        skip_hash,
        ..Default::default()
    };
    match index_path {
        Some(index_path) => {
            if index_path.is_file() && !force {
                anyhow::bail!(
                    "File at \"{}\" already exists, to overwrite use the '-f' flag",
                    index_path.display()
                );
            }
            let mut index = src::index::File::from_state(index, index_path);
            index.write(options)?;
        }
        None => {
            let index = src::index::File::from_state(index, std::path::PathBuf::new());
            let mut out = Vec::with_capacity(512 * 1024);
            index.write_to(&mut out, options)?;
        }
    }

    Ok(())
}

pub mod entries;
pub use entries::function::entries;
