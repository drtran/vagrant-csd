ECHO OFF
REM 
REM Installing all required software packages for a CSD class.
REM This works only when vagrant mount point works.
REM At this time, use Virtual Box 3.2.8. Later version causes
REM problem with the file sharing between host and guest.
REM 
REM Don't install mongodb because it will mess up the vbox share files/folders.
REM 
REM Kiet T. Tran 11 June 2015
REM 

SET VAGRANT_DIR=C:\CSD2015\vagrant
cd %VAGRANT_DIR%
del %VAGRANT_DIR%\config\results.txt
vagrant ssh -c '/vagrant/config/install-git.bash'
vagrant reload
vagrant ssh -c '/vagrant/config/install-vim.bash'
vagrant reload
vagrant ssh -c '/vagrant/config/install-jdk8.bash'
vagrant reload
vagrant ssh -c '/vagrant/config/install-tomee.bash'
vagrant reload
vagrant ssh -c '/vagrant/config/install-sonarqube.bash'
vagrant reload
vagrant ssh -c '/vagrant/config/install-mysql.bash'
vagrant reload
REM vagrant ssh -c '/vagrant/config/install-mongodb.bash'
REM vagrant reload
vagrant ssh -c '/vagrant/config/install-ruby.bash'
vagrant reload
vagrant ssh -c '/vagrant/config/install-node.bash'
vagrant reload
vagrant ssh -c '/vagrant/config/install-maven.bash'
vagrant reload