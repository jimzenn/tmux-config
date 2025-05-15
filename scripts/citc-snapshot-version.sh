#!/bin/sh
_path_prefix="/google/src/cloud/$USER"

case $1 in
  "$_path_prefix"/*)
    _workspace=$(echo "${1#$_path_prefix/}" | cut -d'/' -f1)
    if [ -n "$_workspace" ]; then
      if [ -f "$_path_prefix/$_workspace/.citc/snapshot_version" ]; then
        cat "$_path_prefix/$_workspace/.citc/snapshot_version"
      fi
    fi
    ;;
esac
