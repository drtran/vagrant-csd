#!/usr/bin/bash
echo on

##
## Must edit THIS FILE with UNIX EOL.
## git: git config core.autocrlf false
##

cfg_dir="/vagrant/config"
source "$cfg_dir/utils.bash"

##
## Installing MAVEN 3.3.3
##
log "Installing MAVEN ..."
cd /tmp
sudo wget http://www.gtlib.gatech.edu/pub/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz
sudo tar xvf apache-maven-3.3.3-bin.tar.gz
sudo mv apache-maven-3.3.3 /usr/local/apache-maven-3.3.3
sudo alternatives --install /usr/bin/mvn mvn /usr/local/apache-maven-3.3.3/bin/mvn 1
verify "mvn" "--version" "3.3.3"

