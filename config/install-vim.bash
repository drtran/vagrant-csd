#!/usr/bin/bash
echo on

##
## Must edit THIS FILE with UNIX EOL.
##

cfg_dir="/vagrant/config"
source "$cfg_dir/utils.bash"

##
## Installing vim
##
log "Installing vim ..."
sudo yum -y install vim-common vim-enhanced vim-minimal
verify "vim" "--version" "Vi IMproved 7.4"
