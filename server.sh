#!/bin/bash

OUTPUT="server_report.csv"

echo "Hostname,CPU_Load,Memory_Used,Disk_Used" > $OUTPUT

HOST=$(hostname)
CPU=$(uptime | awk -F'load average:' '{print $2}')
MEM=$(free -m | awk '/Mem:/ {print $3}')
DISK=$(df -h / | awk 'NR==2 {print $5}')

echo "$HOST,$CPU,$MEM,$DISK" >> $OUTPUT

echo "Report Generated: $OUTPUT"