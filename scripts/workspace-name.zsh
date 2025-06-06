#!/usr/bin/zsh
readonly BASE_PATH="/google/src/cloud"

case $1 in
  "$BASE_PATH"/*/*)
    path_suffix="${1#$BASE_PATH/}"
    citc_user=$(echo "$path_suffix" | cut -d'/' -f1)
    workspace=$(echo "$path_suffix" | cut -d'/' -f2)
    if [ -n "$citc_user" ] && [ -n "$workspace" ]; then
      snapshot_file="$BASE_PATH/$citc_user/$workspace/.citc/snapshot_version"
      if [ -f "$snapshot_file" ]; then
        if [ -d "$workspace_path/.hg" ]; then
          _prefix=$FIG_CHAR
        else
          _prefix=$PIPER_CHAR
        fi
      echo "$_prefix$workspace"
      fi
    fi
    ;;
esac
