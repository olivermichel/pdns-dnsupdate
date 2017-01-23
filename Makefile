all: Dockerfile assets/run_pdns.sh assets/pdns.conf assets/schema.sql
	docker build -t olivermichel/pdns-dnsupdate .

run:
	docker run -d -p 8001:8001/tcp -p 53:53/udp -p 53:53/tcp pdns

.PHONY: all run
