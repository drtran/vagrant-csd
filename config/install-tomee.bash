#!/usr/bin/bash
echo on
echo 'configuring csd-vb'

##
## configure-csd2015.sh
## Installing and configuring necessary components for the CSD labs
##
## I installed tomee, jenkins, and sonar qube first because they take
## sometimes to get started ...
## 
## I then verify these apps at the end in hope that they are up and running
## by then. It may be not so if your machine is slow .:)
##
## Must edit THIS FILE with UNIX EOL.
## git: git config core.autocrlf false
##

resultsfile=/vagrant/config/results.txt
touch $resultsfile

##
## Installing git
##
log "Installing git ..."
sudo yum -y install git
verify "git" "--version" "1.8.3.1"

##
## Installing vim
##
log "Installing vim ..."
sudo yum -y install vim-common vim-enhanced vim-minimal
verify "vim" "--version" "Vi IMproved 7.4"

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

##
## Installing & starting TOMEE 1.7.2
##
log "Installing tomee 1.7.2 ..."
cd /tmp
sudo wget http://www.us.apache.org/dist/tomee/tomee-1.7.2/apache-tomee-1.7.2-plume.tar.gz
sudo tar xzf apache-tomee-1.7.2-plume.tar.gz
sudo mv apache-tomee-plume-1.7.2 /usr/local/tomee-plume-172
cd /usr/local/tomee-plume-172/bin
sudo ./startup.sh
## have to wait for the server to get started to verify

##
## Installing Jenkins 
##
log "Installing jenkins ..."
sudo cd /usr/local/tomee-plume-172/webapps
sudo wget http://mirrors.jenkins-ci.org/war/latest/jenkins.war
## have to wait for the server to get started to verify

##
## Installing SonarQube 5.1
##
log "Installing SonarQube 5.1 ..."
cd /tmp
sudo wget http://dist.sonar.codehaus.org/sonarqube-5.1.zip
sudo unzip sonarqube-5.1.zip
sudo mv sonarqube-5.1 /opt/sonar
sudo /opt/sonar/bin/linux-x86-64/sonar.sh start

## have to wait for the server to get started to verify


## 
## Installing MySQL
##
log "Installing MySQL ..."
cd /tmp
sudo rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
sudo yum -y install mysql-community-server
sudo /usr/bin/systemctl enable mysqld
sudo /usr/bin/systemctl start mysqld
# Changing root password
rootpsw = mysql
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$rootpsw');" > tmpfile
mysql --host=localhost --user=root --password= < tmpfile
mysql --host=localhost --user=root --password=mysql < mysql-access.sql
mysql --host=localhost --user=root --password=mysql < northwind-sql.sql
# Verifying install
verify "mysql" "--version" "5.6.25"
# Open up ports for remote access
sudo service mysql restart
sudo iptables -I INPUT -p tcp --dport 3306 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -I OUTPUT -p tcp --sport 3306 -m state --state ESTABLISHED -j ACCEPT

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
verify "mongo" "--verion" "2.6.10"

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

## 
## Installing curl and RUBY
##
log "Installing MAVEN ..."
cd /tmp
sudo yum -y update
sudo yum -y install curl
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -L get.rvm.io | bash -s stable
source /home/vagrant/.rvm/scripts/rvm
rvm requirements
rvm install 1.9.3
rvm use 1.9.3 --default
rvm rubygems current
gem install rails
verify "ruby" "--version" "1.9.3p551"

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

##

## ----------------------------------------
## 
## $1: app-name
## $2: version-param
## $2: expected-version
##
## verify "git" "--version" "1.8.3.1"
##
## ----------------------------------------
function verify() {
  appname=$1
  versionparam=$2
  expectedversion=$3
  now=$(date)
  $appname $versionparam > /tmp/actualversion;
  found=$(grep -ic $expectedversion /tmp/actualversion)
  if [ $found -eq 1 ] 
  then
    echo "$now: $1 installed successfully."  >> $resultsfile
  else
    echo "$now: $1 NOT installed successfully." >> $resultsfile
  fi
}

function log() {
  now=$(date)
  echo "$now: $1" >> $resultsfile
}