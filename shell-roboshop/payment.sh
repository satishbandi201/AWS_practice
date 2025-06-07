#!/bin/bash

source ./common.sh
appname=payment

dnf install python3 gcc python3-devel -y
VALIDATE $? "install python3"

getcode

cd /app 
pip3 install -r requirements.txt
VALIDATE $? "install requirements"

service

