#!/usr/bin/bash
echo on

##
## Must edit THIS FILE with UNIX EOL.
##

cfg_dir="$(dirname "$0")"
"$cfg_dir/utils.bash"

##
## Installing git
##
log "Installing git ..."
sudo yum -y install git
verify "git" "--version" "1.8.3.1"

