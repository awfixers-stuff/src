# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.1.5 (2024-05-22)

A maintenance release without user-facing changes.

### Commit Statistics

<csr-read-only-do-not-edit/>

 - 3 commits contributed to the release over the course of 8 calendar days.
 - 68 days passed between releases.
 - 0 commits were understood as [conventional](https://www.conventionalcommits.org).
 - 0 issues like '(#ID)' were seen in commit messages

### Commit Details

<csr-read-only-do-not-edit/>

<details><summary>view details</summary>

 * **Uncategorized**
    - Adjust changelogs prior to release ([`9511416`](https://github.com/Byron/gitoxide/commit/9511416a6cd0c571233f958c165329c8705c2498))
    - Merge branch 'status' ([`04ef31e`](https://github.com/Byron/gitoxide/commit/04ef31e9d6f5332d49037a5a4c248ebbb5aaf92b))
    - Adapt to changes in `src-pack` ([`bad5b48`](https://github.com/Byron/gitoxide/commit/bad5b48e4f0d865b0b0937f136d9a0041aa88046))
</details>

## 0.1.4 (2024-03-14)

A maintenance release without user-facing changes.

### Commit Statistics

<csr-read-only-do-not-edit/>

 - 4 commits contributed to the release over the course of 4 calendar days.
 - 75 days passed between releases.
 - 0 commits were understood as [conventional](https://www.conventionalcommits.org).
 - 0 issues like '(#ID)' were seen in commit messages

### Commit Details

<csr-read-only-do-not-edit/>

<details><summary>view details</summary>

 * **Uncategorized**
    - Release src-date v0.8.5, src-hash v0.14.2, src-trace v0.1.8, src-utils v0.1.11, src-features v0.38.1, src-actor v0.31.0, src-validate v0.8.4, src-object v0.42.0, src-path v0.10.7, src-glob v0.16.2, src-quote v0.4.12, src-attributes v0.22.2, src-command v0.3.6, src-filter v0.11.0, src-fs v0.10.1, src-chunk v0.4.8, src-commitgraph v0.24.2, src-hashtable v0.5.2, src-revwalk v0.13.0, src-traverse v0.38.0, src-worktree-stream v0.11.0, src-archive v0.11.0, src-config-value v0.14.6, src-tempfile v13.1.1, src-lock v13.1.1, src-ref v0.43.0, src-sec v0.10.6, src-config v0.36.0, src-prompt v0.8.4, src-url v0.27.2, src-credentials v0.24.2, src-ignore v0.11.2, src-bitmap v0.2.11, src-index v0.31.0, src-worktree v0.32.0, src-diff v0.42.0, src-discover v0.31.0, src-pathspec v0.7.1, src-dir v0.2.0, src-macros v0.1.4, src-mailmap v0.23.0, src-negotiate v0.13.0, src-pack v0.49.0, src-odb v0.59.0, src-packetline v0.17.4, src-transport v0.41.2, src-protocol v0.44.2, src-revision v0.27.0, src-refspec v0.23.0, src-status v0.7.0, src-submodule v0.10.0, src-worktree-state v0.9.0, src v0.60.0, safety bump 26 crates ([`b050327`](https://github.com/Byron/gitoxide/commit/b050327e76f234b19be921b78b7b28e034319fdb))
    - Prepare changelogs prior to release ([`52c3bbd`](https://github.com/Byron/gitoxide/commit/52c3bbd36b9e94a0f3a78b4ada84d0c08eba27f6))
    - Merge branch 'status' ([`3e5c974`](https://github.com/Byron/gitoxide/commit/3e5c974dd62ac134711c6c2f5a5490187a6ea55e))
    - Fix lints for nightly, and clippy ([`f8ce3d0`](https://github.com/Byron/gitoxide/commit/f8ce3d0721b6a53713a9392f2451874f520bc44c))
</details>

## 0.1.3 (2023-12-30)

<csr-id-3bd09ef120945a9669321ea856db4079a5dab930/>

### Chore

- <csr-id-3bd09ef120945a9669321ea856db4079a5dab930/> change `rust-version` manifest field back to 1.65.
  They didn't actually need to be higher to work, and changing them
  unecessarily can break downstream CI.

  Let's keep this value as low as possible, and only increase it when
  more recent features are actually used.

### Commit Statistics

<csr-read-only-do-not-edit/>

 - 3 commits contributed to the release.
 - 1 commit was understood as [conventional](https://www.conventionalcommits.org).
 - 0 issues like '(#ID)' were seen in commit messages

### Commit Details

<csr-read-only-do-not-edit/>

<details><summary>view details</summary>

 * **Uncategorized**
    - Release src-date v0.8.3, src-hash v0.14.1, src-trace v0.1.6, src-features v0.37.1, src-actor v0.29.1, src-validate v0.8.3, src-object v0.40.1, src-path v0.10.3, src-glob v0.15.1, src-quote v0.4.10, src-attributes v0.21.1, src-command v0.3.2, src-packetline-blocking v0.17.2, src-utils v0.1.8, src-filter v0.8.1, src-fs v0.9.1, src-chunk v0.4.7, src-commitgraph v0.23.1, src-hashtable v0.5.1, src-revwalk v0.11.1, src-traverse v0.36.1, src-worktree-stream v0.8.1, src-archive v0.8.1, src-config-value v0.14.3, src-tempfile v12.0.1, src-lock v12.0.1, src-ref v0.40.1, src-sec v0.10.3, src-config v0.33.1, src-prompt v0.8.2, src-url v0.26.1, src-credentials v0.23.1, src-ignore v0.10.1, src-bitmap v0.2.10, src-index v0.28.1, src-worktree v0.29.1, src-diff v0.39.1, src-discover v0.28.1, src-macros v0.1.3, src-mailmap v0.21.1, src-negotiate v0.11.1, src-pack v0.46.1, src-odb v0.56.1, src-pathspec v0.5.1, src-packetline v0.17.2, src-transport v0.40.1, src-protocol v0.43.1, src-revision v0.25.1, src-refspec v0.21.1, src-status v0.4.1, src-submodule v0.7.1, src-worktree-state v0.6.1, src v0.57.1 ([`972241f`](https://github.com/Byron/gitoxide/commit/972241f1904944e8b6e84c6aa1649a49be7a85c3))
    - Merge branch 'msrv' ([`8c492d7`](https://github.com/Byron/gitoxide/commit/8c492d7b7e6e5d520b1e3ffeb489eeb88266aa75))
    - Change `rust-version` manifest field back to 1.65. ([`3bd09ef`](https://github.com/Byron/gitoxide/commit/3bd09ef120945a9669321ea856db4079a5dab930))
</details>

## 0.1.2 (2023-12-29)

<csr-id-aea89c3ad52f1a800abb620e9a4701bdf904ff7d/>

### Chore

- <csr-id-aea89c3ad52f1a800abb620e9a4701bdf904ff7d/> upgrade MSRV to v1.70
  Our MSRV follows the one of `helix`, which in turn follows Firefox.

### Commit Statistics

<csr-read-only-do-not-edit/>

 - 5 commits contributed to the release over the course of 14 calendar days.
 - 22 days passed between releases.
 - 1 commit was understood as [conventional](https://www.conventionalcommits.org).
 - 0 issues like '(#ID)' were seen in commit messages

### Commit Details

<csr-read-only-do-not-edit/>

<details><summary>view details</summary>

 * **Uncategorized**
    - Release src-date v0.8.2, src-hash v0.14.0, src-trace v0.1.5, src-features v0.37.0, src-actor v0.29.0, src-validate v0.8.2, src-object v0.40.0, src-path v0.10.2, src-glob v0.15.0, src-quote v0.4.9, src-attributes v0.21.0, src-command v0.3.1, src-packetline-blocking v0.17.1, src-utils v0.1.7, src-filter v0.8.0, src-fs v0.9.0, src-chunk v0.4.6, src-commitgraph v0.23.0, src-hashtable v0.5.0, src-revwalk v0.11.0, src-traverse v0.36.0, src-worktree-stream v0.8.0, src-archive v0.8.0, src-config-value v0.14.2, src-tempfile v12.0.0, src-lock v12.0.0, src-ref v0.40.0, src-sec v0.10.2, src-config v0.33.0, src-prompt v0.8.1, src-url v0.26.0, src-credentials v0.23.0, src-ignore v0.10.0, src-bitmap v0.2.9, src-index v0.28.0, src-worktree v0.29.0, src-diff v0.39.0, src-discover v0.28.0, src-macros v0.1.2, src-mailmap v0.21.0, src-negotiate v0.11.0, src-pack v0.46.0, src-odb v0.56.0, src-pathspec v0.5.0, src-packetline v0.17.1, src-transport v0.40.0, src-protocol v0.43.0, src-revision v0.25.0, src-refspec v0.21.0, src-status v0.4.0, src-submodule v0.7.0, src-worktree-state v0.6.0, src v0.57.0, src-fsck v0.2.0, gitoxide-core v0.35.0, gitoxide v0.33.0, safety bump 40 crates ([`e1aae19`](https://github.com/Byron/gitoxide/commit/e1aae191d7421c748913c92e2c5883274331dd20))
    - Prepare changelogs of next release ([`e78a92b`](https://github.com/Byron/gitoxide/commit/e78a92bfeda168b2f35bb7ba9a94175cdece12f2))
    - Merge branch 'maintenance' ([`4454c9d`](https://github.com/Byron/gitoxide/commit/4454c9d66c32a1de75a66639016c73edbda3bd34))
    - Upgrade MSRV to v1.70 ([`aea89c3`](https://github.com/Byron/gitoxide/commit/aea89c3ad52f1a800abb620e9a4701bdf904ff7d))
    - Merge branch 'main' into fix-1183 ([`1691ba6`](https://github.com/Byron/gitoxide/commit/1691ba669537f4a39ebb0891747dc509a6aedbef))
</details>

## 0.1.1 (2023-12-06)

A maintenance release without user-facing changes.

### Commit Statistics

<csr-read-only-do-not-edit/>

 - 6 commits contributed to the release over the course of 46 calendar days.
 - 88 days passed between releases.
 - 0 commits were understood as [conventional](https://www.conventionalcommits.org).
 - 0 issues like '(#ID)' were seen in commit messages

### Commit Details

<csr-read-only-do-not-edit/>

<details><summary>view details</summary>

 * **Uncategorized**
    - Release src-worktree v0.28.0, src-diff v0.38.0, src-discover v0.27.0, src-macros v0.1.1, src-mailmap v0.20.1, src-negotiate v0.10.0, src-pack v0.45.0, src-odb v0.55.0, src-pathspec v0.4.1, src-packetline v0.17.0, src-transport v0.39.0, src-protocol v0.42.0, src-revision v0.24.0, src-refspec v0.20.0, src-status v0.3.0, src-submodule v0.6.0, src-worktree-state v0.5.0, src v0.56.0, src-fsck v0.1.0, gitoxide-core v0.34.0, gitoxide v0.32.0 ([`d3fd11e`](https://github.com/Byron/gitoxide/commit/d3fd11ec3783843d4e49081e1d14359ed9714b5f))
    - Release src-date v0.8.1, src-hash v0.13.2, src-trace v0.1.4, src-features v0.36.1, src-actor v0.28.1, src-validate v0.8.1, src-object v0.39.0, src-path v0.10.1, src-glob v0.14.1, src-quote v0.4.8, src-attributes v0.20.1, src-command v0.3.0, src-packetline-blocking v0.17.0, src-utils v0.1.6, src-filter v0.7.0, src-fs v0.8.1, src-chunk v0.4.5, src-commitgraph v0.22.1, src-hashtable v0.4.1, src-revwalk v0.10.0, src-traverse v0.35.0, src-worktree-stream v0.7.0, src-archive v0.7.0, src-config-value v0.14.1, src-tempfile v11.0.1, src-lock v11.0.1, src-ref v0.39.0, src-sec v0.10.1, src-config v0.32.0, src-prompt v0.8.0, src-url v0.25.2, src-credentials v0.22.0, src-ignore v0.9.1, src-bitmap v0.2.8, src-index v0.27.0, src-worktree v0.28.0, src-diff v0.38.0, src-discover v0.27.0, src-macros v0.1.1, src-mailmap v0.20.1, src-negotiate v0.10.0, src-pack v0.45.0, src-odb v0.55.0, src-pathspec v0.4.1, src-packetline v0.17.0, src-transport v0.39.0, src-protocol v0.42.0, src-revision v0.24.0, src-refspec v0.20.0, src-status v0.3.0, src-submodule v0.6.0, src-worktree-state v0.5.0, src v0.56.0, src-fsck v0.1.0, gitoxide-core v0.34.0, gitoxide v0.32.0, safety bump 27 crates ([`55d386a`](https://github.com/Byron/gitoxide/commit/55d386a2448aba1dd22c73fb63b3fd5b3a8401c9))
    - Prepare changelogs prior to release ([`d3dcbe5`](https://github.com/Byron/gitoxide/commit/d3dcbe5c4e3a004360d02fbfb74a8fad52f19b5e))
    - J fmt ([`51c7abc`](https://github.com/Byron/gitoxide/commit/51c7abc65f368b1b2bd3d82473793d3cd4fcbad5))
    - Merge branch 'size-optimization' ([`c0e72fb`](https://github.com/Byron/gitoxide/commit/c0e72fbadc0a494f47a110aebb46462d7b9f5664))
    - Remove CHANGELOG.md from all packages ([`b65a80b`](https://github.com/Byron/gitoxide/commit/b65a80b05c9372e752e7e67fcc5c073f71da164a))
</details>

## 0.1.0 (2023-09-08)

The initial release with support for the `momo` proc-macro.

### Commit Statistics

<csr-read-only-do-not-edit/>

 - 15 commits contributed to the release over the course of 13 calendar days.
 - 0 commits were understood as [conventional](https://www.conventionalcommits.org).
 - 0 issues like '(#ID)' were seen in commit messages

### Commit Details

<csr-read-only-do-not-edit/>

<details><summary>view details</summary>

 * **Uncategorized**
    - Release src-date v0.8.0, src-hash v0.13.0, src-features v0.34.0, src-actor v0.26.0, src-object v0.36.0, src-path v0.10.0, src-glob v0.12.0, src-attributes v0.18.0, src-packetline-blocking v0.16.6, src-filter v0.4.0, src-fs v0.6.0, src-commitgraph v0.20.0, src-hashtable v0.4.0, src-revwalk v0.7.0, src-traverse v0.32.0, src-worktree-stream v0.4.0, src-archive v0.4.0, src-config-value v0.14.0, src-tempfile v9.0.0, src-lock v9.0.0, src-ref v0.36.0, src-sec v0.10.0, src-config v0.29.0, src-prompt v0.7.0, src-url v0.23.0, src-credentials v0.19.0, src-diff v0.35.0, src-discover v0.24.0, src-ignore v0.7.0, src-index v0.24.0, src-macros v0.1.0, src-mailmap v0.18.0, src-negotiate v0.7.0, src-pack v0.42.0, src-odb v0.52.0, src-pathspec v0.2.0, src-packetline v0.16.6, src-transport v0.36.0, src-protocol v0.39.0, src-revision v0.21.0, src-refspec v0.17.0, src-submodule v0.3.0, src-worktree v0.25.0, src-worktree-state v0.2.0, src v0.53.0, safety bump 39 crates ([`8bd0456`](https://github.com/Byron/gitoxide/commit/8bd045676bb2cdc02624ab93e73ff8518064ca38))
    - Prepare changelogs for release ([`375db06`](https://github.com/Byron/gitoxide/commit/375db06a8442378c3f7a922fae38e2a6694d9d04))
    - Merge branch 'feat/src-momo' ([`a1ed6a1`](https://github.com/Byron/gitoxide/commit/a1ed6a1aacae02a167b7ec44e1a47411a2194ff7))
    - Consolidate compile tests ([`d76efdd`](https://github.com/Byron/gitoxide/commit/d76efddf5afb73563ce7e837cf975cedd01e979c))
    - Revert to use `item_fn.span()` ([`72545e9`](https://github.com/Byron/gitoxide/commit/72545e971c894de511a723f6d5515f637a84f28f))
    - Fix ui test `error_if_ineffective` ([`9be2622`](https://github.com/Byron/gitoxide/commit/9be26220876498df4d1add77da45c415268a77dc))
    - Add test-suite for failure modes ([`c8e7324`](https://github.com/Byron/gitoxide/commit/c8e732430f3740348ccedd0dc1a9a28b06a0adee))
    - Remove `TODO` in `src-macros/src/lib.rs` ([`c4ed7c1`](https://github.com/Byron/gitoxide/commit/c4ed7c180e3ec1ff75cb10d78d4b8eed3b75be2f))
    - Improve docs ([`705f2f3`](https://github.com/Byron/gitoxide/commit/705f2f34f1fa95d767646b154f41d2a6ce65ad10))
    - Refactor ([`48a2088`](https://github.com/Byron/gitoxide/commit/48a20888d158b94811074a09a8c57ff5c8410769))
    - Feat `momo`: Rm unnecessary `#[allow(unused_mut)]` on generated inner fn ([`b619456`](https://github.com/Byron/gitoxide/commit/b6194568e1d3042305f472103e1c00549cc4ccb9))
    - Feat `momo`: Support parsing pattern in params ([`b5f78be`](https://github.com/Byron/gitoxide/commit/b5f78be06792153cd981c316a486974c000f1fd8))
    - Dramatically simplify `gix_macros::momo` ([`c72eaa0`](https://github.com/Byron/gitoxide/commit/c72eaa05697a3e34adaa3ee90584dce4b5c00120))
    - Remove `TryInto` support from `gix_macros::momo` ([`95a1626`](https://github.com/Byron/gitoxide/commit/95a16264b0a6f8c7d8e2acded3a4c9c170c2729b))
    - Add new crate `src-macros` ([`6dae9e9`](https://github.com/Byron/gitoxide/commit/6dae9e9d455ba5e3bf18c452789d07ff6cfaf392))
</details>

