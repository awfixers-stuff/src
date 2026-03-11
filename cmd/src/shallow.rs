pub(crate) type CommitsStorage =
    src_features::threading::OwnShared<src_fs::SharedFileSnapshotMut<nonempty::NonEmpty<src_hash::ObjectId>>>;
/// A lazily loaded and auto-updated list of commits which are at the shallow boundary (behind which there are no commits available),
/// sorted to allow bisecting.
pub type Commits = src_fs::SharedFileSnapshot<nonempty::NonEmpty<src_hash::ObjectId>>;

///
pub mod read {
    pub use src_shallow::read::Error;
}

///
pub mod write {
    pub use src_shallow::write::Error;
}
