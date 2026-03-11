use crate::util::named_repo;

#[test]
fn tree_merge_options() -> crate::Result {
    let repo = named_repo("make_basic_repo.sh")?;
    let opts: src::merge::plumbing::tree::Options = repo.tree_merge_options()?.into();
    assert_eq!(
        opts.rewrites,
        Some(src::diff::Rewrites::default()),
        "If merge options aren't set, it defaults to diff options, and these default to doing rename tracking"
    );
    Ok(())
}
