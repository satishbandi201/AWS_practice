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
##package checking

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed, going to install"

    dnf install -y mysql
    if [ $? -eq 0 ]
    then
        echo "mysql installed successfully"
    else
        echo "mysql installed failed!"
    fi
else
    echo "mysql already installed."
    exit 2
fi