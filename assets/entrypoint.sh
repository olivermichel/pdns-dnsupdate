#!/usr/bin/env sh

SCHEMA_FILE=/etc/pdns/schema.sql

if [ -f ${SCHEMA_FILE} ]; then
	sqlite3 /srv/pdns.sqlite < ${SCHEMA_FILE}
	rm ${SCHEMA_FILE}
fi

pdns_server \
	--api=${PDNS_API:-yes} \
    --api-key=${PDNS_API_KEY:-43bUUEqtGQKG3Umaa8uMhqCTdYYHVaCE} \
	--webserver-address=${PDNS_WEBSERVER_ADDRESS:-0.0.0.0} \
	--webserver-port=${PDNS_WEBSERVER_PORT:-42902} \
    --webserver-allow-from=${PDNS_WEBSERVER_ALLOW_FROM:-0.0.0.0/0,::/0} \
    --dnsupdate=yes \
    --master=yes \
    --setgid=pdns \
    --setuid=pdns \
	--daemon=no \
	--disable-tcp=no \
	--launch=gsqlite3 \
	--gsqlite3-database=/srv/pdns.sqlite