#!/usr/bin/zsh
readonly BASE_PATH="/google/src/cloud"
if [[ $1 == "$BASE_PATH"/*/* ]]; then
  path_suffix=${1#$BASE_PATH/}
  IFS='/' read -r citc_user workspace _ <<< "$path_suffix"
  snapshot_file="$BASE_PATH/$citc_user/$workspace/.citc/snapshot_version"
  if [[ -f $snapshot_file ]]; then
    printf "⍆ℝ"
    cat "$snapshot_file"
  fi
fi
