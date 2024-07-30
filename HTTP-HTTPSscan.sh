#! /bin/bash

# This scripted is build to help analyze the http and https/
# of a given site for info-gathering

echo Enter the starting ip address.
read FirstIp

echo Enter the lastoctet of ip address.
read LastOctetIp

echo Enter the port number you want to scan.
read Port

echo confirm the Ip address to be scanned $FirstIp.$LastOctetIp

nmap -sT $FirstIp.$LastOctetIp -p $Port >/dev/null -oG HTTPscan 
cat HTTPscan | grep open > HTTPscan2

cat HTTPscan2
