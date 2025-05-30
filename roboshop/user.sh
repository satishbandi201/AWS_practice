#!/bin/bash

source ./common.sh
appname=user

nodejs

cp $SCRIPT_DIR/user.service /etc/systemd/system/user.service
VALIDATE $? "copying user service"

service
