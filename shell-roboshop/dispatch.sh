#!/bin/bash

source ./common.sh
appname=dispatch

dnf install golang -y
VALIDATE $? "install golang"

getcode

cd /app 
go mod init dispatch
go get 
go build
VALIDATE $? "install depencies"

service
