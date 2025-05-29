#!/bin/bash

source ./common.sh
appname=mysql

echo "Please enter root password to setup"
read -s MYSQL_ROOT_PASSWORD

dnf install mysql-server -y &>>$LOG_FILE
VALIDATE $? "install mysql"

systemctl enable mysqld &>>$LOG_FILE
VALIDATE $? "enable mysql"

systemctl start mysqld &>>$LOG_FILE
VALIDATE $? "start mysql"

mysql_secure_installation --set-root-pass $MYSQL_ROOT_PASSWORD &>>$LOG_FILE
VALIDATE $? "set password for mysql"
