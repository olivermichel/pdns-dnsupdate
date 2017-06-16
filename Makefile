all: Dockerfile assets/pdns.conf assets/schema.sql
	docker build -t olivermichel/pdns-dnsupdate .

.PHONY: all
