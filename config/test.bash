#!/usr/bin/bash
echo on
echo 'testing'


cfg_dir="/vagrant/config"
source "$cfg_dir/utils.bash"

##
## Installing vim
##
log "Test logging ..."
verify "git" "--version" "1.3.8.1"
verify "java" "-version" "1.8.0_25"
log "test logging ends ..."
