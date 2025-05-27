#!/bin/bash
USER=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SCRIPT_DIR=$PWD

LOG_DIR="/var/log/AWS_logs"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1)
LOG_FILE=$LOG_DIR/$SCRIPT_NAME.log

mkdir -p $LOG_DIR
##user access checking

if [ $USER -eq 0 ]
then
    echo -e "you are running with $G root access $N" | tee -a $LOG_FILE
else
    echo -e "$R you are not a root user $N" | tee -a $LOG_FILE
    exit 1
fi

##VALIDATING COMMAND

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is $G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$2 is $R FAILED $N" | tee -a $LOG_FILE
    fi
}


mongorepo(){
    cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo
    VALIDATE $? "copying mpongo repo"
}


##NODEJS
nodejs(){
    dnf module disable nodejs -y &>>$LOG_FILE
    VALIDATE $? "disabiling nodejs"

    dnf module enable nodejs:20 -y &>>$LOG_FILE
    VALIDATE $? "enabiling nodejs:20"

    dnf install nodejs -y &>>$LOG_FILE
    VALIDATE $? "install nodejs" 

    #user creation check
    id roboshop
    if [ $? -eq 0 ]
    then
        echo -e "roboshop user already $G Exist $N" | tee -a $LOG_FILE
    else
        useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
        VALIDATE $? "roboshop user creation"
    fi

    mkdir -p /app
    cd /tmp
    rm -rf /tmp/*.zip
    curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>$LOG_FILE
    VALIDATE $? "get zip code from git"

    cd /app
    rm -rf /app/*
    unzip /tmp/catalogue.zip &>>$LOG_FILE
    VALIDATE $? "unzip the code in app folder"

    npm install &>>$LOG_FILE
    VALIDATE $? "installing npm"

    cp $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service
    VALIDATE $? "copying configuration file"
 
    systemctl daemon-reload &>>$LOG_FILE
    VALIDATE $? "reload"

    systemctl enable catalogue &>>$LOG_FILE
    VALIDATE $? "enable the catalogue"

    systemctl start catalogue &>>$LOG_FILE
    VALIDATE $? "Start catalogue"
}


