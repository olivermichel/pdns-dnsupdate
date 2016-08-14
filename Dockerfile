
FROM centos:centos7

MAINTAINER Oliver Michel <oliver.michel@editum.de>

EXPOSE 53/udp
EXPOSE 53/tcp
EXPOSE 8001/tcp

ENV PDNS_WEBSERVER_PASSWORD aUqg6aTS

VOLUME ["/srv/pdns"]

RUN curl -o /etc/yum.repos.d/powerdns-auth-40.repo https://repo.powerdns.com/repo-files/centos-auth-40.repo && \
  yum -y upgrade && \
  yum -y install epel-release yum-plugin-priorities pdns pdns-backend-sqlite && \
  yum clean all

COPY assets/run_pdns.sh /opt/run_pdns.sh
COPY assets/pdns.conf /etc/pdns/pdns.conf
COPY assets/schema.sql /srv/pdns/schema.sql

ENTRYPOINT ["/opt/run_pdns.sh"]
