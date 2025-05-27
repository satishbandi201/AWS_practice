#!/bin/bash
USER=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SCRIPT_DIR=$PWD

##user access checking

if [ $USER -ne 0 ]
then
    echo -e "you are running with $G root access $N"
else
    echo -e "$R you are not a root user $N"
    exit 1
fi

##VALIDATING COMMAND

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo "$2 is $G SUCCESS $N"
    else
        echo "$2 is $R FAILED $N"
    fi
}


mongorepo(){
    cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo
    VALIDATE $? "copying mpongo repo"
}
