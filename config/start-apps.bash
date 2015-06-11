#!/usr/bin/bash
echo 'starting apps'

#
# Edit with UNIX EOL only
#
cd /usr/local/tomee-plume-172/bin
sudo ./catalina.sh start

cd /opt/sonar/bin/linux-x86-64
sudo ./sonar.sh start

