#!/usr/bin/bash
echo on
echo 'configuring csd-vb'

##
## Must edit THIS FILE with UNIX EOL.
##

cfg_dir="/vagrant/config"
source "$cfg_dir/utils.bash"

##
## Installing ORACLE JDK 8
##
log "Installing JDK 8 ..."
cd /opt
sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-x64.tar.gz"
sudo tar xvf jdk-8u25-linux-x64.tar.gz
sudo chown -R root: jdk1.8.0_25
sudo alternatives --install /usr/bin/java java /opt/jdk1.8.0_25/bin/java 1
sudo alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_25/bin/javac 1
sudo alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_25/bin/jar 1
sudo rm /opt/jdk-8u25-linux-x64.tar.gz
verify "java" "-version" "1.8.0_25"
