#!/usr/bin/bash
echo on

##
## Must edit THIS FILE with UNIX EOL.
## git: git config core.autocrlf false
##

cfg_dir="/vagrant/config"
source "$cfg_dir/utils.bash"

## 
## Installing mongodb.
##
log "Installing mongodb ..."
cd /tmp
sudo cp /vagrant/config/mongodb.repo /etc/yum.repos.d/.
sudo yum -y update
sudo yum -y install mongodb-org mongodb-org-server
sudo systemctl start mongod
sudo systemctl status mongod
verify "mongo" "--version" "2.6.10"

