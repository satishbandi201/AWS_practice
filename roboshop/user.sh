#!/bin/bash

source ./common.sh
appname=user

nodejs
getcode

cd /app 
npm install 
VALIDATE $? "npm install"

service
