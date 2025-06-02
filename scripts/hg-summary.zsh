#! /usr/bin/zsh
cd $1
chg log -T'{GOOG_commit_desc}' --config google_hgext.daemon=False | head -n 1
