#!/bin/zsh
readonly BASE_PATH="/google/src/cloud"

case $1 in
  "$BASE_PATH"/*/*)
    path_suffix="${1#$BASE_PATH/}"
    citc_user=$(echo "$path_suffix" | cut -d'/' -f1)
    workspace=$(echo "$path_suffix" | cut -d'/' -f2)
    if [ -n "$citc_user" ] && [ -n "$workspace" ]; then
      workspace_id_file="$BASE_PATH/$citc_user/$workspace/.citc/workspace_id"
      if [ -f "$workspace_id_file" ]; then
        cat $workspace_id_file
      fi
    fi
    ;;
esac

