FROM docker.n8n.io/n8nio/n8n:latest

USER root

RUN apk add --no-cache libaio wget unzip

ARG INSTANT_CLIENT_VERSION=21_13
RUN wget https://download.oracle.com/otn_software/linux/instantclient/2113000/instantclient-basic-linux.x64-21.13.0.0.0dbru.zip \
    && unzip instantclient-basic-linux.x64-21.13.0.0.0dbru.zip -d /opt \
    && rm instantclient-basic-linux.x64-21.13.0.0.0dbru.zip \
    && ln -s /opt/instantclient_21_13 /opt/instantclient

ENV LD_LIBRARY_PATH=/opt/instantclient:$LD_LIBRARY_PATH
ENV ORACLE_HOME=/opt/instantclient
ENV TNS_ADMIN=/opt/instantclient/network/admin

RUN npm install -g oracledb

RUN chown -R node:node /usr/local/lib/node_modules \
    && mkdir -p /home/node/.n8n \
    && chown -R node:node /home/node

USER node
