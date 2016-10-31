#!/bin/sh

export LE_LOG=/var/log/letsencrypt/letsencrypt.log

rm -f /etc/env
for varname in `env | grep -o "^[A-Z_0-9]*"`; do
  echo "$varname=\"`printenv $varname`\"" >> /etc/env
done

echo "0 0 1 * * /letsencrypt-runner.sh --renew-by-default --text" | crontab -

if [ -z "$1" ]; then
  touch $LE_LOG
  set -- tail -f $LE_LOG & crond -f
fi

exec $@
