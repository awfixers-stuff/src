#!/usr/bin/env bash

set -eu -o pipefail

function enter () {
  local dir="${1:?need directory to enter}"
  printf '  in %s \t→\t' "$dir"
  cd -- "$dir"
}

function indent () {
  "$@" | grep -F 'package size' | while IFS= read -r line; do
    echo "     $line"
  done
}

echo 'in root: gitoxide CLI'
(enter src-fsck && indent cargo diet -n --package-size-limit 10KB)
(enter src-actor && indent cargo diet -n --package-size-limit 10KB)
(enter src-archive && indent cargo diet -n --package-size-limit 10KB)
(enter src-worktree-stream && indent cargo diet -n --package-size-limit 40KB)
(enter src-utils && indent cargo diet -n --package-size-limit 10KB)
(enter src-fs && indent cargo diet -n --package-size-limit 15KB)
(enter src-pathspec && indent cargo diet -n --package-size-limit 30KB)
(enter src-refspec && indent cargo diet -n --package-size-limit 30KB)
(enter src-path && indent cargo diet -n --package-size-limit 25KB)
(enter src-attributes && indent cargo diet -n --package-size-limit 25KB)
(enter src-discover && indent cargo diet -n --package-size-limit 35KB)
(enter src-index && indent cargo diet -n --package-size-limit 65KB)
(enter src-worktree && indent cargo diet -n --package-size-limit 40KB)
(enter src-quote && indent cargo diet -n --package-size-limit 10KB)
(enter src-revision && indent cargo diet -n --package-size-limit 40KB)
(enter src-bitmap && indent cargo diet -n --package-size-limit 10KB)
(enter src-tempfile && indent cargo diet -n --package-size-limit 35KB)
(enter src-lock && indent cargo diet -n --package-size-limit 25KB)
(enter src-config && indent cargo diet -n --package-size-limit 140KB)
(enter src-config-value && indent cargo diet -n --package-size-limit 20KB)
(enter src-command && indent cargo diet -n --package-size-limit 10KB)
(enter src-hash && indent cargo diet -n --package-size-limit 30KB)
(enter src-chunk && indent cargo diet -n --package-size-limit 15KB)
(enter src-features && indent cargo diet -n --package-size-limit 65KB)
(enter src-ref && indent cargo diet -n --package-size-limit 55KB)
(enter src-diff && indent cargo diet -n --package-size-limit 35KB)
(enter src-traverse && indent cargo diet -n --package-size-limit 15KB)
(enter src-url && indent cargo diet -n --package-size-limit 35KB)
(enter src-validate && indent cargo diet -n --package-size-limit 10KB)
(enter src-date && indent cargo diet -n --package-size-limit 25KB)
(enter src-hashtable && indent cargo diet -n --package-size-limit 10KB)
(enter src-filter && indent cargo diet -n --package-size-limit 35KB)
(enter src-status && indent cargo diet -n --package-size-limit 30KB)
(enter src-sec && indent cargo diet -n --package-size-limit 25KB)
(enter src-credentials && indent cargo diet -n --package-size-limit 35KB)
(enter src-prompt && indent cargo diet -n --package-size-limit 15KB)
(enter src-object && indent cargo diet -n --package-size-limit 35KB)
(enter src-commitgraph && indent cargo diet -n --package-size-limit 35KB)
(enter src-pack && indent cargo diet -n --package-size-limit 140KB)
(enter src-odb && indent cargo diet -n --package-size-limit 140KB)
(enter src-protocol && indent cargo diet -n --package-size-limit 80KB)
(enter src-packetline && indent cargo diet -n --package-size-limit 45KB)
(enter src && indent cargo diet -n --package-size-limit 280KB)
(enter src-transport && indent cargo diet -n --package-size-limit 95KB)
(enter gitoxide-core && indent cargo diet -n --package-size-limit 160KB)
