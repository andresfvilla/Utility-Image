FROM ubuntu:16.04
MAINTAINER Andres Villa <andresfvilla88@gmail.com>

#Install dependencies
#This is used to generate load on the clients

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
     ansible \
     curl \
     default-jre \
     default-jdk \
     dnsutils \
     iperf \
     mtr \
     netcat \
     nodejs \
     npm \
     python \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install --no-install-recommends -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

#requires unsafe due to npm having permission problems from "unnamed" user
RUN npm install -g grpcc --unsafe

CMD ["tail", "-F", "-n0", "/etc/hosts"]
