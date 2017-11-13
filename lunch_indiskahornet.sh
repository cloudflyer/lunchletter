#!/bin/bash
export LANG=sv_SE.UTF-8
MAILTO="bob@example.com scott@example.com"
MAILFROM="noreply@example.com"
TODAY=`date +%A`
TODAYNUM="$`date --date='+1 day' +%w`"
if hash curl 2>/dev/null; then
  if hash lynx 2>/dev/null; then
    if [ "$TODAY" != "fredag" ]; then
      curl -s http://www.indiskahornet.se/lunch_meny.html | sed -e '1,/'$TODAY'/Id' -e '/<h3>/,$d' >>\
      indiskahornet.html && echo "<br/><br/>Source: http://www.indiskahornet.se" >> \
      indiskahornet.html && lynx -cfg <(echo COLLAPSE_BR_TAGS:FALSE) -assume_charset=utf-8 -display_charset=utf-8 -nolist -dump indiskahornet.html | \
      mailx -r $MAILFROM -s "Dagens Lunch - Indiska Hörnet - "${TODAY^} $MAILTO

      rm indiskahornet.html
    else
      curl -s http://www.indiskahornet.se/lunch_meny2.html | sed -e '1,/'$TODAY'/Id' -e '/<h3>/,$d' >>\
      indiskahornet.html && echo "<br/><br/>Source: http://www.indiskahornet.se" >> \
      indiskahornet.html && lynx -cfg <(echo COLLAPSE_BR_TAGS:FALSE) -assume_charset=utf-8 -display_charset=utf-8 -nolist -dump indiskahornet.html | \
      mailx -r $MAILFROM -s "Dagens Lunch - Indiska Hörnet - "${TODAY^} $MAILTO

      rm indiskahornet.html
    fi 
  else
    echo "Error: Lynx is not available, exiting!"
    exit 1
  fi
else
  echo "Error: Curl is not available, exiting!"
  exit 1
fi
exit 0
