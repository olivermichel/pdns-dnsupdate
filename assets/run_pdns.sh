#!/usr/bin/env bash

if [[ ! -e /srv/pdns/pdns.sqlite3 ]]; then
    sqlite3 pdns.sqlite3 < /srv/pdns/schema.sql
    mv pdns.sqlite3 /srv/pdns/pdns.sqlite3
    chown pdns:pdns /srv/pdns /srv/pdns/pdns.sqlite3
    rm /srv/pdns/schema.sql
fi

/usr/sbin/pdns_server
