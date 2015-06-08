#!/usr/bin/bash
echo on

##
## Must edit THIS FILE with UNIX EOL.
##

results_file="$cfg_dir/results.txt"
tmp_dir="/tmp"

## ----------------------------------------
## 
## $1: app_name
## $2: version_param
## $2: expected_version
##
## verify "git" "--version" "1.8.3.1"
##
## ----------------------------------------
function verify() {
  app_name=$1
  version_param=$2
  expected=$3
  now=$(date)
  $app_name $version_param > "$tmp_dir/tmp_file"
  found=$(grep -ic $expected "$tmp_dir/tmp_file)"
  if [ $found -eq 1 ] 
  then
    echo "$now: $1 installed successfully."  >> $results_file
  else
    echo "$now: $1 NOT installed successfully." >> $results_file
  fi
}

##
## Logging ...
##
function log() {
  now=$(date)
  echo "$now: $1" >> $results_file
}