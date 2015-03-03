#!/bin/bash
MAILTO="thomas.jallbrink@teamquest.com folke.hagberg@teamquest.com pascal.wallenius@teamquest.com linus.agren@teamquest.com"
if hash curl 2>/dev/null; then
  if hash lynx 2>/dev/null; then
    curl -s barabicu.se | awk -F '<li>' '{printf $2}' | awk -F '</li>' '{printf $2}' > barabicu.html && lynx -assume_charset=utf-8 -display_charset=utf-8 -dump barabicu.html | mailx -r lunch@teamquest.com -s "Dagens Lunch - "$(date +"%A %d/%m-%Y") $MAILTO  
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
