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
#RUN npm install -g grpcc

# RUN useradd -d /home/node -m -s /bin/bash node
# USER node
RUN npm install -g grpcc --unsafe

#RUN npm install -g grpcc
CMD ["tail", "-F", "-n0", "/etc/hosts"]
