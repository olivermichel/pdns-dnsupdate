# PowerDNS 4.0 with NS-Update

This repository provides a PowerDNS 4.0 authorative DNS server installation with support for DNS UPDATE ([RFC 2136](https://tools.ietf.org/html/rfc2136) and [RFC 3007](https://tools.ietf.org/html/rfc3007)) configured.

## Building the Image

    docker build -t pdns .

or

    make

## Running the Image

    docker run -d -p 8081:8081/tcp -p 53:53/udp -p 53:52/tcp pdns

To start a shell session inside the container:

    docker exec -it <CONTAINER-ID> /bin/bash

## Configuring a Zone

On the container, you can use pdnsutil to configure a zone to test your setup. In order to add a zone *example.com* with a nameserver *ns1* at 192.168.1.2 and a hostname *newhost* at 192.168.1.3, execute the following commands:

    pdnsutil create-zone example.com ns1.example.com
    pdnsutil add-record example.com ns1 A 192.168.1.2
    pdnsutil add-record example.com new-host A 192.168.1.3

To test your setup, run from the Docker host machine:

    dig +noall +answer newhost.example.com @127.0.0.1

## Configuring DNS UPDATE

In order to use DNS UPDATE securely, a shared secret must be configured. To do so, execute the following command inside the container:

    pdnsutil generate-tsig-key nsupdate-key hmac-md5

To furthermore configure DNS-UPDATE using our new key for the domain *example.com*, run:
    pdnsutil activate-tsig-key example.com nsupdate-key master
    pdnsutil set-meta example.com TSIG-ALLOW-DNSUPDATE nsupdate-key
    pdnsutil set-meta example.com ALLOW-DNSUPDATE-FROM 0.0.0.0/0

You can then retrieve the generated key using:

    pdnsutil list-tsig-keys

## Sending an Update Request

Use the `nsupdate` tool to send DNS UPDATE requests:

    nsupdate -y nsupdate-key:<SHARED-SECRET>

Then, in order to set the IP address for newhost to 172.16.0.1, type

    server 127.0.0.1
    update delete newhost.example.com
    update add newhost.example.com 500 IN A 172.16.0.1
    send
    quit
