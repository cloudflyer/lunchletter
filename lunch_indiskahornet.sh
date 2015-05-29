#!/bin/bash
export LANG=sv_SE.UTF-8
MAILTO="bob@example.com scott@example.com"
MAILFROM="noreply@example.com"
TODAY=`date +%A`
TODAYNUM="$`date --date='+1 day' +%w`"

export LANG=sv_SE.UTF-8
if hash curl 2>/dev/null; then
  if hash lynx 2>/dev/null; then
    curl -s http://indiskahornet.kvartersmenyn.se | sed -e '1,/class=\"day\"/d' \
        -e '/End\ Menu\ List/,$d' | awk -F '<strong>' '{printf '$TODAYNUM'}' >> indiskahornet.html && \
    lynx -assume_charset=utf-8 -display_charset=utf-8 -dump indiskahornet.html | \
    mailx -r $MAILFROM -s "Dagens Lunch - Indiska Hörnet - "${TODAY^} $MAILTO

    rm indiskahornet.html
  else
    echo "Error: Lynx is not available, exiting!"
    exit 1
  fi
else
  echo "Error: Curl is not available, exiting!"
  exit 1
fi
exit 0
