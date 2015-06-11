#!/usr/bin/bash
echo on

##
## Must edit THIS FILE with UNIX EOL.
## git: git config core.autocrlf false
##

cfg_dir="/vagrant/config"
source "$cfg_dir/utils.bash"

##
## Installing node ...
##
log "Installing node.js ..."
cd /tmp
sudo yum -y groupinstall "Development tools"
sudo wget http://nodejs.org/dist/v0.10.30/node-v0.10.30-linux-x64.tar.gz
sudo tar --strip-components 1 -xzvf node-v* -C /usr/local
sudo alternatives --install /usr/bin/node node /usr/local/bin/node 1
verify "node" "--version" "v0.10.30"
