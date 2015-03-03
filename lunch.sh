#!/bin/bash
MAILTO="reciver1@mail.com reciver2@mail.com reciver3@mail.com reciver4@mail.com"
MAILFROM="todayslunch@barabicu.se"
if hash curl 2>/dev/null; then
  if hash lynx 2>/dev/null; then
    curl -s barabicu.se | awk -F '<li>' '{printf $2}' | awk -F '</li>' '{printf $2}' > barabicu.html && lynx -assume_charset=utf-8 -display_charset=utf-8 -dump barabicu.html | mailx -r $MAILFROM -s "Dagens Lunch - "$(date +"%A %d/%m-%Y") $MAILTO  
    rm barabicu.html
  else
    echo "Error: Lynx is not available, exiting!"
    exit 1
  fi
else
  echo "Error: Curl is not available, exiting!"
  exit 1
fi  
exit 0