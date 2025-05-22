#!/bin/bash

var1=123
var2=234
echo "$var1 and $var2"
echo " all variable passed in script : $@"
echo " Number of variable passed in script : $#"
echo " Name of the script : $0"
echo " Current working Directory : $PWD"
echo " User running this script : $USER"
echo " Home Directory of user : $HOME"
echo " PID of the script : $$"
sleep 10 &
echo "PID of last command running in background: $!"