#!/usr/bin/bash
echo on

##
## Must edit THIS FILE with UNIX EOL.
## git: git config core.autocrlf false
##

cfg_dir="/vagrant/config"
source "$cfg_dir/utils.bash"

## 
## Installing curl and RUBY
##
log "Installing Ruby ..."
cd /tmp
sudo yum -y install ruby
sudo yum -y install gcc g++ make automake autoconf curl-devel openssl-devel zlib-devel httpd-devel apr-devel apr-util-devel sqlite-devel
sudo yum -y install ruby-devel
sudo gem update
sudo gem update --system
verify "ruby" "--version" "2.0.0p598"


#cd /tmp
#sudo yum -y update
#sudo yum -y install curl
#gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
#curl -L get.rvm.io | bash -s stable
#source /home/vagrant/.rvm/scripts/rvm
#rvm requirements
#rvm install 1.9.3
#rvm use 1.9.3 --default
#rvm rubygems current
#gem install rails
#verify "ruby" "--version" "1.9.3p551"

# NEW way of installing RUBY?
#
# cd /tmp
# sudo yum -y install ruby
# sudo yum -y install gcc g++ make automake autoconf curl-devel openssl-devel zlib-devel httpd-devel apr-devel apr-util-devel sqlite-devel
# sudo yum -y install ruby-devel
# sudo yum -y install rubygems
# sudo mkdir ~/src
# sudo cd ~/src
# wget http://rubyforge.org/frs/download.php/69365/rubygems-1.3.6.tgz?tar -zxvf rubygems-1.3.6.tgz
# cd rubygems-1.3.6
# sudo ruby setup.rb
# sudo gem update
# sudo gem update --system
# sudo gem install rails -V
# verify "ruby" "--version" "1.9.3p551"