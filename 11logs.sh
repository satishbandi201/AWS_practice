#!/bin/bash
USER=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGPATH="/var/log/Shellscript_logs/"
SCRIPTNAME=$( echo $0 | cut -d "." -f1)
LOGFILE="$LOGPATH/$SCRIPTNAME.log"

mkdir -p $LOGPATH
echo "This script executed at $(date)" | tee -a $LOGFILE

##user access checking
if [ $USER -eq 0 ]
then
    echo -e "you are running with $G root user $N" | tee -a $LOGFILE
else
    echo -e "$R ERROR: you are not a root user $N" | tee -a $LOGFILE
fi

##VALIDATION FUNCTION
VALIDATE (){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is installing... $G SUCCESS $N" | tee -a $LOGFILE
    else
        echo -e "$2 installation $R FAILED $N" | tee -a $LOGFILE
    fi
}

##package installation
dnf list installed mysql &>>$LOGFILE
if [ $? -ne 0 ]
then
    dnf install mysql -y &>>$LOGFILE
    VALIDATE $? "mysql"
else
    echo -e "$Y mysql already installed $N" | tee -a $LOGFILE
fi

dnf list installed nginx &>>$LOGFILE
if [ $? -ne 0 ]
then
    dnf install nginx -y &>>$LOGFILE
    VALIDATE $? "nginx"
else
    echo -e "$Y nginx already installed $N" | tee -a $LOGFILE
fi

dnf list installed nodejs &>>$LOGFILE
if [ $? -ne 0 ]
then
    dnf install nodejs -y &>>$LOGFILE
    VALIDATE $? "nodejs"
else
    echo -e "$Y nodejs already installed $N" | tee -a $LOGFILE
fi