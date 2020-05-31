#!/bin/bash

if [ "$1" = "ragent" ]; then
  if [ ! -f /home/usr1cv8/.1cv8/1C/1cv8/conf/logcfg.xml ]; then
    mkdir --parent /home/usr1cv8/.1cv8/1C/1cv8/conf
    cp -n logcfg.xml /home/usr1cv8/.1cv8/1C/1cv8/conf/logcfg.xml
    chown --recursive usr1cv8:grp1cv8 /home/usr1cv8
  fi
  exec /usr/local/bin/gosu usr1cv8 /opt/1C/v8.3/x86_64/ragent
fi

exec "$@"
