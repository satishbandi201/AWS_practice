#!/bin/bash

source ./common.sh

appname=cart

nodejs
getcode

cd /app 
npm install 
VALIDATE $? "npm install"

service
