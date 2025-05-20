#!/bin/bash
dt=$(date)
 echo "script executed at $dt"
echo "enter first number"
read -s num1
echo "enter second number"
read -s num2
Total=$(($num1+$num2))

echo "sum of $num1 and $num2 is $Total"