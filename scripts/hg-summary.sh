#! /bin/sh
cd $1
chg log -T'{desc}' --config google_hgext.daemon=False | head -n 1
