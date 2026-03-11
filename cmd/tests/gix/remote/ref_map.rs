#[cfg(any(feature = "blocking-network-client", feature = "async-network-client-async-std"))]
mod blocking_and_async_io {
    use src::{config::tree::Protocol, remote::Direction::Fetch};
    use src_features::progress;
    use src_protocol::maybe_async;

    use crate::{
        remote,
        remote::{into_daemon_remote_if_async, spawn_git_daemon_if_async},
    };

    #[maybe_async::test(
        feature = "blocking-network-client",
        async(feature = "async-network-client-async-std", async_std::test)
    )]
    async fn all() -> crate::Result {
        let daemon = spawn_git_daemon_if_async(remote::repo_path("base"))?;
        for (fetch_tags, version, expected_remote_refs, expected_mappings) in [
            (src::remote::fetch::Tags::None, None, 11, 11),
            (
                src::remote::fetch::Tags::None,
                Some(src::protocol::transport::Protocol::V2),
                11,
                11,
            ),
            (
                src::remote::fetch::Tags::Included,
                Some(src::protocol::transport::Protocol::V2),
                17,
                17,
            ),
            (
                src::remote::fetch::Tags::All,
                Some(src::protocol::transport::Protocol::V2),
                17,
                17,
            ),
            (
                src::remote::fetch::Tags::None,
                Some(src::protocol::transport::Protocol::V1),
                18,
                11,
            ),
            (
                src::remote::fetch::Tags::Included,
                Some(src::protocol::transport::Protocol::V1),
                18,
                17,
            ),
            (
                src::remote::fetch::Tags::All,
                Some(src::protocol::transport::Protocol::V1),
                18,
                17,
            ),
        ] {
            let mut repo = remote::repo("clone");
            if let Some(version) = version {
                repo.config_snapshot_mut()
                    .set_raw_value(&Protocol::VERSION, (version as u8).to_string().as_str())?;
            }

            let remote = into_daemon_remote_if_async(
                repo.find_remote("origin")?.with_fetch_tags(fetch_tags),
                daemon.as_ref(),
                None,
            );
            let (map, _handshake) = remote
                .connect(Fetch)
                .await?
                .ref_map(progress::Discard, Default::default())
                .await?;
            assert_eq!(
                    map.remote_refs.len(),
                    expected_remote_refs ,
                    "{version:?} fetch-tags={fetch_tags:?}: it gets all remote refs, independently of the refspec. But we use a prefix so pre-filter them."
                );

            assert_eq!(map.fixes.len(), 0);
            assert_eq!(
                map.mappings.len(),
                expected_mappings,
                "mappings are only a sub-set of all remotes due to refspec matching, tags are filtered out."
            );
        }
        Ok(())
    }
}
