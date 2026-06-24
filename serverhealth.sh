#!/bin/bash

HOSTNAME=$(hostname)
DATE=$(date)

echo "================================="
echo "Server Health Report"
echo "Host : $HOSTNAME"
echo "Date : $DATE"
echo "================================="

echo "CPU Load"
uptime

echo ""
echo "Memory"
free -h

echo ""
echo "Disk"
df -h

echo ""
echo "Logged-in Users"
who