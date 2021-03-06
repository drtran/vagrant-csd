#!/usr/bin/bash
echo on

##
## Must edit THIS FILE with UNIX EOL.
## git: git config core.autocrlf false
##

cfg_dir="/vagrant/config"
source "$cfg_dir/utils.bash"

##
## Installing SonarQube 5.1 & Sonar runner 2.4
##
log "Installing SonarQube 5.1 ..."
cd /tmp
sudo yum install -y unzip
sudo wget http://dist.sonar.codehaus.org/sonarqube-5.1.zip
sudo unzip sonarqube-5.1.zip
sudo mv sonarqube-5.1 /opt/sonar
sudo wget http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip
sudo unzip sonar-runner-dist-2.4.zip
sudo mv sonar-runner-2.4 /opt/sonar
sudo /opt/sonar/bin/linux-x86-64/sonar.sh start


## have to wait for the server to get started to verify
