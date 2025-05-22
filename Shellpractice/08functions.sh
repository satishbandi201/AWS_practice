#!/bin/bash
## user checking
USER=$(id -u)

if [ $USER -ne 0 ]
then
    echo "you are not a root user"
    exit 2
else
    echo "you running with root user"
fi
##Validate function
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo "$2 installed successfully"
    else
        echo "$2 installed failed!"
        exit 1
    fi
}

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed, going to install"

    dnf install -y mysql
    VALIDATE $? "mysql"
else
    echo "mysql already installed."
fi

##python3
dnf list installed python3

if [ $? -ne 0 ]
then
    echo "python3 is not installed, going to install"

    dnf install -y python3
    VALIDATE $? "python3"
else
    echo "python3 already installed."
fi

##nginx
dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "nginx is not installed, going to install"

    dnf install -y nginx
    VALIDATE $? "nginx"
else
    echo "nginx already installed."
fi