FROM apache/apisix:3.12.0-debian
USER root
RUN apt-get update && apt-get install -y curl iputils-ping telnet nmap
USER apisix
