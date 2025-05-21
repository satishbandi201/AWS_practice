#!/bin/bash
USER=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGPATH="/var/log/Shellscript_logs/"
SCRIPTNAME=$( echo $0 | cut -d "." f1)
LOGFILE="$LOGPATH/$SCRIPTNAME.log"

mkdir -p $LOGPATH
echo "This script executed at $(date)" | tee -a $LOGFILE

