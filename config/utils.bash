#!/usr/bin/bash
echo on

##
## Must edit THIS FILE with UNIX EOL.
##

cfg_dir="/vagrant/config"
results_file="$cfg_dir/results.txt"
tmp_dir="/tmp"

## ----------------------------------------
## 
## $1: app_name
## $2: version_param
## $2: expected
##
## verify "git" "--version" "1.8.3.1"
##
## ----------------------------------------
function verify() {
  app_name=$1
  version_param=$2
  expected=$3
  now=$(date)
  $app_name $version_param &> "$tmp_dir/tmp_file"
  found=$(grep -ic "$expected" "$tmp_dir/tmp_file")
  if [ $found -ge 1 ] 
  then
    echo "$now: $app_name $expected installed successfully."  >> $results_file
  else
    echo "$now: $app_name $expected NOT installed successfully." >> $results_file
  fi
}

##
## Logging ...
##
function log() {
  now=$(date)
  echo "$now: $1" >> $results_file
}