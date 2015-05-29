#!/bin/bash
LANG=sv_SE.UTF-8
MAILTO="bob@example.com scott@example.com"
MAILFROM="lunch@example.com"
TODAY=`date +%A`
if hash curl 2>/dev/null; then
  if hash lynx 2>/dev/null; then
    echo "<h3>${TODAY^}</h3><p>" > brewdog.html && \
    curl -s www.brewdogbar.se/restaurangen-goteborg/ | sed -e '1,/Lunch\ vecka/d' \
        -e '/matsal/,$d' \
        -e "1,/${TODAY^}/d" \
        -e '/<p>/,$d' \
        -e 's/&#8211;/-/g' >> brewdog.html && \
    curl -s www.brewdogbar.se/restaurangen-goteborg/ | sed -e '1,/Fredag/d' \
        -e '1,/<\/p>/d' \
        -e '/matsal/,$d' \
        -e '/nbsp/,$d' \
        -e 's/&#8211;/-/g' >> brewdog.html && \
    lynx -assume_charset=utf-8 -display_charset=utf-8 -dump brewdog.html | \
    mailx -r $MAILFROM -s "Dagens Lunch - BREWDOG - "${TODAY^} $MAILTO

    rm brewdog.html
  else
    echo "Error: Lynx is not available, exiting!"
    exit 1
  fi
else
  echo "Error: Curl is not available, exiting!"
  exit 1
fi
exit 0
