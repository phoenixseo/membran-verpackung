#! /usr/bin/bash
# Drupal 8 Production Environment Rebuild Script
# Taken from great work of:
# https://github.com/thom44/deployment/blob/master/deployment/prod-rebuild.sh
# ##################################################################
# Locations:
# project/deployment/prod-rebuild.sh = location of this file
# project/web = Drupal root directory
# project/.git = location of your git repositority
# project/assets/db-dump = the location where the dumps are saved
# project/vendor = composer vendor directory
# project/composer.json

# You may run this script as sudo to change file owner
# sudo ./prod-rebuild.sh
# ##################################################################

# Filesystem on Production Environment Web Server
DRUPAL_USER=automverpack
DRUPAL_GROUP=psacln

# Site Directory - relative from drupal-root
SITE_DIR=sites/default

# Drupal root relative from project path
DRUPAL_DIR=web

# Check absolute path
# This Script sits in project/deployment/
PROJECT_PATH=$(pwd)

DRUPAL_ROOT=$PROJECT_PATH/$DRUPAL_DIR


### Setup automatic Logging of Script Runs #####################################

LOG_DIR=logs

if [ ! -d $PROJECT_PATH/deployment/$LOG_DIR ]; then
    mkdir $PROJECT_PATH/deployment/$LOG_DIR
    chmod 700 $PROJECT_PATH/deployment/$LOG_DIR
fi

now=$(date +"%d_%m_%Y__%H_%M_%S")

logfile=$PROJECT_PATH/deployment/$LOG_DIR/prod-rebuild-$now.log

echo "Time is $now"   2>&1 | tee -a $logfile
echo "Project Path is $PROJECT_PATH" 2>&1 | tee -a $logfile
echo "Drupal Root is $DRUPAL_ROOT"  2>&1 | tee -a $logfile

echo "Logfile is $logfile"



### GIT PULL via Plesk Onyx #########################################
# git pull is done automatically via push from origin (github)
# via webhook settings in github and plesk repository settings.
# this script is called after "git pull origin master".
#

# call composer install
now=$(date +"%d_%m_%Y__%H_%M_%S")

echo "Begin composer install: $now" 2>&1 | tee -a $logfile
/opt/plesk/php/7.3/bin/php /usr/lib64/plesk-9.0/composer.phar install 2>&1 | tee -a $logfile

now=$(date +"%d_%m_%Y__%H_%M_%S")
echo "End composer install: $now" 2>&1 | tee -a $logfile

# end of line.
