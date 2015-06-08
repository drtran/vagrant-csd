#!/usr/bin/bash
echo on
echo 'testing'


cfg_dir="$(dirname "$0")"
"$cfg_dir/utils.bash"

##
## Installing vim
##
log "Test logging ..."
verify "git" "--verion" "1.3.8.1"
log "test logging ends ..."
