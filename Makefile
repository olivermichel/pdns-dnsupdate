build: Dockerfile assets/entrypoint.sh assets/schema.sql
	docker build -t olivermichel/pdns-dnsupdate .

push:
	docker push olivermichel/pdns-dnsupdate

.PHONY: build push