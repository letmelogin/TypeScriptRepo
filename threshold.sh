#!/bin/bash

THRESHOLD=80

USED=$(free | grep Mem | awk '{print int($3/$2 * 100)}')

if [ $USED -gt $THRESHOLD ]
then
    echo "ALERT: Memory Usage is ${USED}%"
else
    echo "Memory Usage Normal: ${USED}%"
fi