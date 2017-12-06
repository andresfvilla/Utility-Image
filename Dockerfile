FROM ubuntu:16.04
MAINTAINER Andres Villa <andresfvilla88@gmail.com>


#Install dependencies
#This is used to generate load on the clients
RUN apt-get update \
    && apt-get install --no-install-recommends -y curl dnsutils grpcc npm python \ 
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g grpcc

USER utils

CMD ["tail", "-F", "-n0", "/etc/hosts"]
