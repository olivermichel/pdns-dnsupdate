#!/usr/bin/env bash

HTTP_PORT=${PDNS_HTTP_PORT:-8001}
API_KEY=${PDNS_API_KEY:-p2jAZcN4CDssy9knbhZLSE3Bz7jdKmK9}
HTTP_PW=${PDNS_HTTP_PW:-p2jAZcN4CDssy9knbhZLSE3Bz7jdKmK9}

sed -i "s/{{HTTP_PORT}}/${HTTP_PORT}/" /etc/pdns/pdns.conf
sed -i "s/{{API_KEY}}/${API_KEY}/" /etc/pdns/pdns.conf
sed -i "s/{{HTTP_PW}}/${HTTP_PW}/" /etc/pdns/pdns.conf

if [ -e "/srv/pdns/schema.sql" ]; then
  cd /srv/pdns
  sqlite3 pdns.sqlite3 < schema.sql
  chown pdns:pdns pdns.sqlite3 && \
  rm schema.sql
fi

/usr/sbin/pdns_server
