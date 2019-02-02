#!/bin/sh

echo USERS WITH HOME
awk -F: '/\/home/ {printf "%s:%s\n",$1,$3}' /etc/passwd
echo .
echo .

echo USERS UID >= 1000
awk -F: '($3 >= 1000) {printf "%s:%s\n",$1,$3}' /etc/passwd
echo .
echo .

echo ALL USERS
awk -F: '{printf "%s:%s\n",$1,$3}' /etc/passwd