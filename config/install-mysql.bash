#!/usr/bin/bash
echo on

##
## Must edit THIS FILE with UNIX EOL.
##

cfg_dir="/vagrant/config"
source "$cfg_dir/utils.bash"

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
rootpsw="mysql"
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$rootpsw');" > tmpfile
mysql --host=localhost --user=root --password= < tmpfile
mysql --host=localhost --user=root --password=$rootpsw < /vagrant/config/mysql-access.sql
mysql --host=localhost --user=root --password=$rootpsw < /vagrant/config/northwind-sql.sql
# Open up ports for remote access
sudo service mysql restart
sudo iptables -I INPUT -p tcp --dport 3306 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -I OUTPUT -p tcp --sport 3306 -m state --state ESTABLISHED -j ACCEPT
# Verifying install
verify "mysql" "--version" "5.6.25"
