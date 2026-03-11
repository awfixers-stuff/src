#!/usr/bin/env -S just --justfile
# ^ A shebang isn't required, but allows a justfile to be executed
#   like a script, with `./justfile test`, for example.

j := quote(just_executable())

# List available recipes
default:
    {{ j }} --list

alias t := test
alias c := check
alias nt := nextest

# Run all tests, clippy, including journey tests, try building docs
test: clippy check doc unit-tests journey-tests-pure journey-tests-small journey-tests-async journey-tests check-mode

# Run all tests, without clippy, and try building docs
ci-test: check doc unit-tests check-mode

# Run all journey tests - should be run in a fresh clone or after `cargo clean`
ci-journey-tests: journey-tests-pure journey-tests-small journey-tests-async journey-tests

# Clean the `target` directory
clear-target:
    cargo clean

# Run `cargo clippy` on all crates
clippy *clippy-args:
    cargo clippy --workspace --all-targets -- {{ clippy-args }}
    cargo clippy --workspace --no-default-features --features small -- {{ clippy-args }}
    cargo clippy --workspace --no-default-features --features max-pure -- {{ clippy-args }}
    cargo clippy --workspace --no-default-features --features lean-async --tests -- {{ clippy-args }}

# Run `cargo clippy` on all crates, fixing what can be fixed, and format all code
clippy-fix:
    cargo clippy --fix --workspace --all-targets
    cargo clippy --fix --allow-dirty --workspace --no-default-features --features small
    cargo clippy --fix --allow-dirty --workspace --no-default-features --features max-pure
    cargo clippy --fix --allow-dirty --workspace --no-default-features --features lean-async --tests
    cargo fmt --all

# Build all code in suitable configurations
check:
    cargo check --workspace
    cargo check --no-default-features --features small
    cargo check -p src-packetline --all-features 2>/dev/null
    cargo check -p src-transport --all-features 2>/dev/null
    # assure compile error occurs
    ! cargo check --features lean-async 2>/dev/null
    ! cargo check -p gitoxide-core --all-features --features src/sha1 2>/dev/null
    ! cargo check -p src-protocol --all-features 2>/dev/null
    # warning happens if nothing found, no exit code :/
    cargo --color=never tree -p src --no-default-features -e normal -i imara-diff \
        2>&1 >/dev/null | grep '^warning: nothing to print\>'
    cargo --color=never tree -p src --no-default-features -e normal -i src-submodule \
        2>&1 >/dev/null | grep '^warning: nothing to print\>'
    cargo --color=never tree -p src --no-default-features -e normal -i src-pathspec \
        2>&1 >/dev/null | grep '^warning: nothing to print\>'
    cargo --color=never tree -p src --no-default-features -e normal -i src-filter \
        2>&1 >/dev/null | grep '^warning: nothing to print\>'
    ! cargo tree -p src --no-default-features -i src-credentials 2>/dev/null
    cargo check --no-default-features --features lean
    cargo check --no-default-features --features lean-async
    cargo check --no-default-features --features max
    cargo check -p gitoxide-core --features src/sha1,blocking-client
    cargo check -p gitoxide-core --features src/sha1,async-client
    cargo check -p src-pack --no-default-features 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-pack --no-default-features --features sha1
    cargo check -p src-pack --no-default-features --features sha1,generate
    cargo check -p src-pack --no-default-features --features sha1,streaming-input
    cargo check -p src-hash --all-features
    cargo check -p src-hash 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-hash --features sha1
    cargo check -p src-hash --features sha256
    cargo check -p src-hashtable 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-hashtable --features sha1
    cargo check -p src-object --all-features
    cargo check -p src-object --features verbose-object-parsing-errors 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-object --features sha1,verbose-object-parsing-errors
    cargo check -p src-archive 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-archive --features sha1
    cargo check -p src-attributes --features serde
    cargo check -p src-blame 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-blame --features sha1
    cargo check -p src-glob --features serde
    cargo check -p src-worktree --features serde 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-worktree --features sha1,serde
    cargo check -p src-worktree --no-default-features --features sha1
    cargo check -p src-worktree-state 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-worktree-state --features sha1
    cargo check -p src-worktree-stream 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-worktree-stream --features sha1
    cargo check -p src-actor --features serde
    cargo check -p src-date --features serde
    cargo check -p src-dir 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-dir --features sha1
    cargo check -p src-discover 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-discover --features sha1
    cargo check -p src-filter 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-filter --features sha1
    cargo check -p src-fsck 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-fsck --features sha1
    cargo check -p src-tempfile --features signals
    cargo check -p src-tempfile --features hp-hashmap
    cargo check -p src-merge 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-merge --features sha1
    cargo check -p src-negotiate 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-negotiate --features sha1
    cargo check -p src-pack --features serde 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-pack --features sha1,serde
    cargo check -p src-pack --features sha1,pack-cache-lru-static
    cargo check -p src-pack --features sha1,pack-cache-lru-dynamic
    cargo check -p src-pack --features sha1,object-cache-dynamic
    cargo check -p src-packetline --features blocking-io
    cargo check -p src-packetline --features async-io
    cargo check -p src-index --features serde 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-index --features sha1,serde
    cargo check -p src-credentials --features serde
    cargo check -p src-sec --features serde
    cargo check -p src-ref 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-ref --features sha1
    cargo check -p src-refspec 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-refspec --features sha1
    cargo check -p src-revision --features serde 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-revision --features sha1,serde
    cargo check -p src-revision --no-default-features --features sha1,describe
    cargo check -p src-revwalk 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-revwalk --features sha1
    cargo check -p src-shallow 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-shallow --features sha1
    cargo check -p src-mailmap --features serde
    cargo check -p src-url --all-features
    cargo check -p src-status 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-status --features sha1
    cargo check -p src-status --all-features
    cargo check -p src-submodule 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-submodule --features sha1
    cargo check -p src-traverse 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-traverse --features sha1
    cargo check -p src-features --all-features
    cargo check -p src-features --features parallel
    cargo check -p src-features --features fs-read-dir
    cargo check -p src-features --features progress
    cargo check -p src-features --features io-pipe
    cargo check -p src-features --features crc32
    cargo check -p src-features --features zlib
    cargo check -p src-features --features cache-efficiency-debug
    cargo check -p src-commitgraph 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-commitgraph --all-features
    cargo check -p src-config-value --all-features
    cargo check -p src-config 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-config --all-features
    cargo check -p src-diff --no-default-features 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-diff --no-default-features --features sha1
    cargo check -p src-transport --features blocking-client
    cargo check -p src-transport --features async-client
    cargo check -p src-transport --features async-client,async-std
    cargo check -p src-transport --features http-client
    cargo check -p src-transport --features http-client-curl
    cargo check -p src-transport --features http-client-reqwest
    cargo check -p src-protocol --features blocking-client 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-protocol --features sha1,blocking-client
    cargo check -p src-protocol --features sha1,async-client
    cargo check -p src --no-default-features --features sha1,async-network-client
    cargo check -p src --no-default-features --features sha1,async-network-client-async-std
    cargo check -p src --no-default-features --features sha1,blocking-network-client
    cargo check -p src --no-default-features --features sha1,blocking-http-transport-curl
    cargo check -p src --no-default-features --features sha1,blocking-http-transport-reqwest
    cargo check -p src --no-default-features --features max-performance --tests
    cargo check -p src --no-default-features --features max-performance-safe --tests
    cargo check -p src --no-default-features --features progress-tree --tests
    cargo check -p src --no-default-features --features blob-diff --tests
    cargo check -p src --no-default-features --features revision --tests
    cargo check -p src --no-default-features --features revparse-regex --tests
    cargo check -p src --no-default-features --features mailmap --tests
    cargo check -p src --no-default-features --features excludes --tests
    cargo check -p src --no-default-features --features attributes --tests
    cargo check -p src --no-default-features --features worktree-mutation --tests
    cargo check -p src --no-default-features --features credentials --tests
    cargo check -p src --no-default-features --features index --tests
    cargo check -p src --no-default-features --features interrupt --tests
    cargo check -p src --no-default-features --features blame --tests
    cargo check -p src --no-default-features --features sha1
    cargo check -p src-odb --features serde 2>&1 >/dev/null | grep 'Please set either the `sha1` or the `sha256` feature flag'
    cargo check -p src-odb --features sha1,serde
    cargo check --no-default-features --features max-control,sha1

# Run `cargo doc` on all crates
doc $RUSTDOCFLAGS='-D warnings':
    cargo doc --workspace --no-deps --features need-more-recent-msrv
    cargo doc --features=max,lean,small --workspace --no-deps --features need-more-recent-msrv

# Run all unit tests
unit-tests:
    cargo nextest run --no-fail-fast
    cargo nextest run -p src-testtools --no-fail-fast
    cargo nextest run -p src-testtools --features xz --no-fail-fast
    cargo nextest run -p src-archive --no-default-features --no-fail-fast
    cargo nextest run -p src-archive --no-default-features --features tar --no-fail-fast
    cargo nextest run -p src-archive --no-default-features --features tar_gz --no-fail-fast
    cargo nextest run -p src-archive --no-default-features --features zip --no-fail-fast
    cargo nextest run -p src-status-tests --features src-features-parallel --no-fail-fast
    cargo nextest run -p src-worktree-state-tests --features src-features-parallel --no-fail-fast
    cargo nextest run -p src-worktree-tests --features src-features-parallel --no-fail-fast
    cargo nextest run -p src-error --no-fail-fast --test auto-chain-error --features auto-chain-error
    cargo nextest run -p src-error --no-fail-fast
    cargo nextest run -p src-hash --features sha1 --no-fail-fast
    cargo nextest run -p src-hash --features sha1,sha256 --no-fail-fast
    cargo nextest run -p src-hash --features sha256 --no-fail-fast
    env src_TEST_FIXTURE_HASH=sha1 cargo nextest run -p src-commitgraph --no-fail-fast
    env src_TEST_FIXTURE_HASH=sha256 cargo nextest run -p src-commitgraph --no-fail-fast
    cargo nextest run -p src-object --no-fail-fast
    cargo nextest run -p src-object --features verbose-object-parsing-errors --no-fail-fast
    cargo nextest run -p src-tempfile --features signals --no-fail-fast
    cargo nextest run -p src-features --all-features --no-fail-fast
    cargo nextest run -p src-ref-tests --all-features --no-fail-fast
    cargo nextest run -p src-odb --all-features --no-fail-fast
    cargo nextest run -p src-odb-tests --features src-features-parallel --no-fail-fast
    env src_TEST_FIXTURE_HASH=sha1 cargo nextest run -p src-pack --all-features --no-fail-fast
    env src_TEST_FIXTURE_HASH=sha256 cargo nextest run -p src-pack --all-features --no-fail-fast
    cargo nextest run -p src-pack-tests --features all-features --no-fail-fast
    cargo nextest run -p src-pack-tests --features src-features-parallel --no-fail-fast
    cargo nextest run -p src-index-tests --features src-features-parallel --no-fail-fast
    cargo nextest run -p src-packetline --features blocking-io,maybe-async/is_sync --test blocking-packetline --no-fail-fast
    cargo nextest run -p src-packetline --features async-io --test async-packetline --no-fail-fast
    cargo nextest run -p src-transport --features http-client-curl,maybe-async/is_sync --no-fail-fast
    cargo nextest run -p src-transport --features http-client-reqwest,maybe-async/is_sync --no-fail-fast
    cargo nextest run -p src-transport --features async-client --no-fail-fast
    cargo nextest run -p src-protocol --features blocking-client --no-fail-fast
    cargo nextest run -p src-protocol --features async-client --no-fail-fast
    cargo nextest run -p src-blame --no-fail-fast
    cargo nextest run -p src --no-default-features --no-fail-fast
    cargo nextest run -p src --no-default-features --features basic,comfort,max-performance-safe --no-fail-fast
    cargo nextest run -p src --no-default-features --features basic,extras,comfort,need-more-recent-msrv --no-fail-fast
    cargo nextest run -p src --features async-network-client --no-fail-fast
    cargo nextest run -p src --features blocking-network-client --no-fail-fast
    cargo nextest run -p gitoxide-core --lib --no-tests=warn --no-fail-fast
    cargo test --workspace --doc --no-fail-fast

# These tests aren't run by default as they are flaky (even locally)
unit-tests-flaky:
    cargo test -p src --features async-network-client-async-std

# Extract cargo metadata, excluding dependencies, and query it
[private]
query-meta jq-query:
    meta="$(cargo metadata --format-version 1 --no-deps)" && \
        printf '%s\n' "$meta" | jq --exit-status --raw-output -- {{ quote(jq-query) }}

# Get the path to the directory where debug binaries are created during builds
[private]
dbg: (query-meta '.target_directory + "/debug"')

# Run journey tests (`max`)
journey-tests:
    cargo build --features http-client-curl-rustls
    cargo build -p src-testtools --bin jtt
    dbg="$({{ j }} dbg)" && tests/journey.sh "$dbg/ein" "$dbg/src" "$dbg/jtt" max

# Run journey tests (`max-pure`)
journey-tests-pure:
    cargo build --no-default-features --features max-pure
    cargo build -p src-testtools --bin jtt
    dbg="$({{ j }} dbg)" && tests/journey.sh "$dbg/ein" "$dbg/src" "$dbg/jtt" max-pure

# Run journey tests (`small`)
journey-tests-small:
    cargo build --no-default-features --features small
    cargo build -p src-testtools
    dbg="$({{ j }} dbg)" && tests/journey.sh "$dbg/ein" "$dbg/src" "$dbg/jtt" small

# Run journey tests (`lean-async`)
journey-tests-async:
    cargo build --no-default-features --features lean-async
    cargo build -p src-testtools
    dbg="$({{ j }} dbg)" && tests/journey.sh "$dbg/ein" "$dbg/src" "$dbg/jtt" async

# Build a customized `cross` container image for testing
cross-image target:
    docker build --build-arg "TARGET={{ target }}" \
        -t "cross-rs-gitoxide:{{ target }}" \
        -f etc/docker/Dockerfile.test-cross etc/docker/test-cross-context

# Test another platform with `cross`
cross-test target options test-options: (cross-image target)
    CROSS_CONFIG=etc/docker/test-cross.toml NO_PRELOAD_CXX=1 \
        cross test --workspace --no-fail-fast --target {{ target }} \
        {{ options }} -- --skip realpath::fuzzed_timeout {{ test-options }}

# Test s390x with `cross`
cross-test-s390x: (cross-test 's390x-unknown-linux-gnu' '' '')

# Test Android with `cross` (max-pure)
cross-test-android: (cross-test 'armv7-linux-androideabi' '--no-default-features --features max-pure' '')

# Run `cargo diet` on all crates to see that they are still in bounds
check-size:
    etc/scripts/check-package-size.sh

# Report the Minimum Supported Rust Version (the `rust-version` of `src`) in X.Y.Z form
msrv: (query-meta '''
    .packages[]
    | select(.name == "src")
    | .rust_version
    | sub("(?<xy>^[0-9]+[.][0-9]+$)"; "\(.xy).0")
''')

# Regenerate the MSRV badge SVG
msrv-badge:
    msrv="$({{ j }} msrv)" && \
        sed "s/{MSRV}/$msrv/g" etc/msrv-badge.template.svg >etc/msrv-badge.svg

# Check if `src` and its dependencies, as currently locked, build with `rust-version`
check-rust-version rust-version:
    rustc +{{ rust-version }} --version
    cargo +{{ rust-version }} build --locked -p src
    cargo +{{ rust-version }} build --locked -p src \
        --no-default-features --features async-network-client,max-performance,sha1

# Enter a nix-shell able to build on macOS
nix-shell-macos:
    nix-shell -p pkg-config openssl libiconv darwin.apple_sdk.frameworks.Security darwin.apple_sdk.frameworks.SystemConfiguration

# Run various auditing tools to help us stay legal and safe
audit:
    cargo deny --workspace --all-features check advisories bans licenses sources

# Run tests with `cargo nextest` (all unit-tests, no doc-tests, faster)
nextest *FLAGS='--workspace':
    cargo nextest run {{ FLAGS }}

# Run tests with `cargo nextest`, skipping none except as filtered, omitting status reports
summarize EXPRESSION='all()':
    cargo nextest run --workspace --run-ignored all --no-fail-fast \
        --status-level none --final-status-level none -E {{ quote(EXPRESSION) }}

# Run nightly `rustfmt` for its extra features, but check that it won't upset stable `rustfmt`
fmt:
    cargo +nightly fmt --all -- --config-path rustfmt-nightly.toml
    cargo +stable fmt --all -- --check
    {{ j }} --fmt --unstable

# Cancel this after the first few seconds, as yanked crates will appear in warnings
find-yanked:
    cargo install --debug --locked --no-default-features --features max-pure --path .

# Find shell scripts whose +x/-x bits and magic bytes (e.g. `#!`) disagree
check-mode:
    cargo build -p internal-tools
    cargo run -p internal-tools -- check-mode

# Get the unique `v*` tag at `HEAD`, or fail with an error
unique-v-tag:
    etc/scripts/unique-v-tag.sh

# Trigger the `release.yml` workflow on the current `v*` tag
run-release-workflow repo='':
    optional_repo_arg={{ quote(repo) }} && \
        export GH_REPO="${optional_repo_arg:-"${GH_REPO:-GitoxideLabs/gitoxide}"}" && \
        tag_name="$({{ j }} unique-v-tag)" && \
        printf 'Running release.yml in %s repo for %s tag.\n' "$GH_REPO" "$tag_name" && \
        gh workflow run release.yml --ref "refs/tags/$tag_name"

# Run `cargo smart-release` and then trigger `release.yml` for the `v*` tag
roll-release *csr-args:
    cargo smart-release {{ csr-args }}
    {{ j }} run-release-workflow
