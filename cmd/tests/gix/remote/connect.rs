#[cfg(feature = "blocking-network-client")]
mod blocking_io {
    mod protocol_allow {
        use src::remote::Direction::Fetch;
        use serial_test::serial;

        use crate::remote;

        #[test]
        fn deny() {
            for name in ["protocol_denied", "protocol_file_denied"] {
                let repo = remote::repo(name);
                let remote = repo.find_remote("origin").unwrap();
                assert!(matches!(
                    remote.connect(Fetch).err(),
                    Some(src::remote::connect::Error::ProtocolDenied {
                        url: _,
                        scheme: src::url::Scheme::File
                    })
                ));
            }
        }

        #[test]
        #[serial]
        fn user() -> crate::Result {
            for (env_value, should_allow) in [(None, true), (Some("0"), false), (Some("1"), true)] {
                let _env = env_value.map(|value| src_testtools::Env::new().set("GIT_PROTOCOL_FROM_USER", value));
                let repo = src::open_opts(
                    remote::repo("protocol_file_user").git_dir(),
                    src::open::Options::isolated().permissions(src::open::Permissions {
                        env: src::open::permissions::Environment {
                            git_prefix: src_sec::Permission::Allow,
                            ..src::open::permissions::Environment::all()
                        },
                        ..src::open::Permissions::isolated()
                    }),
                )?;
                let remote = repo.find_remote("origin")?;
                assert_eq!(remote.connect(Fetch).is_ok(), should_allow, "Value = {env_value:?}");
            }
            Ok(())
        }
    }
}
