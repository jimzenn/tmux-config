#!/bin/sh
_path_prefix="/google/src/cloud/$USER"

case $1 in
  "$_path_prefix"/*)
    _workspace=$(echo "${1#$_path_prefix/}" | cut -d'/' -f1)
    if [ -n "$_workspace" ]; then
      if [ -d "$_path_prefix/$_workspace/.hg" ]; then
        _prefix=$FIG_CHAR
      else
        _prefix=$PIPER_CHAR
      fi
      if [ -f "$_path_prefix/$_workspace/.citc/snapshot_version" ]; then
        echo "$_prefix$_workspace|$(cat $_path_prefix/$_workspace/.citc/snapshot_version)"
      fi
    fi
    ;;
esac
