#! /bin/bash

# This scirpt is designed to find hosts with MYSQL installed

#'echo Enter your ip address 
#read IP
#echo Confirm your ip address $IP

#nmap -sT -P 80 $IP >/dev/null -oG MySQLscan

#cat MySQLscan | grep open > MySQLscan2
#cat MySQLscan2

# Adding prompt and variables to our script
echo Enter the starting ip address.
read FirstIp

echo Enter the lastoctet of ip address.
read LastOctetIp

echo Enter the port number you want to scan.
read Port

echo confirm the Ip address to be scanned $FirstIp.$LastOctetIp

nmap -sT $FirstIp.$LastOctetIp -p $Port >/dev/null -oG MySQLscan 
cat MySQLscan | grep open > MySQLscan2

cat MySQLscan2
