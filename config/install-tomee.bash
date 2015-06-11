#!/usr/bin/bash
echo on

##
## Must edit THIS FILE with UNIX EOL.
## git: git config core.autocrlf false
##

cfg_dir="/vagrant/config"
source "$cfg_dir/utils.bash"

##
## Installing & starting TOMEE
##
log "Installing tomee ..."
cd /tmp
sudo wget http://www.us.apache.org/dist/tomee/tomee-1.7.2/apache-tomee-1.7.2-plume.tar.gz
sudo tar xzf apache-tomee-1.7.2-plume.tar.gz
sudo mv apache-tomee-plume-1.7.2 /usr/local/tomee-plume-172
sudo /usr/local/tomee-plume-172/bin/catalina.sh start
log "Complete installing tomee ..."

verify "/usr/local/tomee-plume-172/bin/catalina.sh" "version" "7.0.62"
## have to wait for the server to get started to verify

##
## Installing Jenkins 
##
log "Installing jenkins-ci ..."
cd /tmp
wget http://mirrors.jenkins-ci.org/war/latest/jenkins.war
sudo mv jenkins.war /usr/local/tomee-plume-172/webapps/.
log "Completed installing jenkins-ci ..."
## have to wait for the server to get started to verify
