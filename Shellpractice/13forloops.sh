#!/bin/bash

USER=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGFOLDER="/var/log/Shellscript_logs"
SCRIPTNAME=$( echo $0 | cut -d "." -f1)
LOGFILE=$LOGFOLDER/$SCRIPTNAME.log

PACKAGES=("mysql" "nginx" "nodejs" "httpd")

##user access checking
if [ $USER -eq 0 ]
then
    echo -e "you are running with $G root user $N" | tee -a $LOGFILE
else
    ehco -e "$R ERROR: you are not root user $N" | tee -a $LOGFILE
fi

##VALIDATE
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is installing $G SUCCESS $N" | tee -a $LOGFILE
    else
        echo -e "$2 installation $R FAILED $N" | tee -a $LOGFILE
    fi
}

##installing packages using for loop

for package in ${PACKAGES[@]}
do 
    dnf list installed $package &>>$LOGFILE
    if [ $? -ne 0 ]
    then
    dnf install $package -y &>>$LOGFILE
    VALIDATE $? "$package"
    else
    echo -e "$Y $package is already installed $N" | tee -a $LOGFILE
    fi
done