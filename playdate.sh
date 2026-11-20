#!/usr/bin/env bash
# Start Copilot CLI in clanker-daycare with one or more target repos attached.
set -euo pipefail

usage() { echo "usage: $(basename "$0") <repo> [<repo>...] [-- <copilot args>]" >&2; exit 1; }

root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repos=()
while [[ $# -gt 0 && "$1" != "--" ]]; do
  [[ -d "$1" ]] || { echo "not a directory: $1" >&2; exit 1; }
  repos+=("$(cd "$1" && pwd)")
  shift
done
[[ "${1:-}" == "--" ]] && shift
[[ ${#repos[@]} -gt 0 ]] || usage

add_dirs=()
for r in "${repos[@]}"; do add_dirs+=(--add-dir "$r"); done

cd "$root"
# Unquoted so COPILOT_CMD can hold a multi-word command.
COPILOT_CUSTOM_INSTRUCTIONS_DIRS="$(IFS=,; echo "${repos[*]}")" \
  exec ${COPILOT_CMD:-copilot} "${add_dirs[@]}" "$@"
