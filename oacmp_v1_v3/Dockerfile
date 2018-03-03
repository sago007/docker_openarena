FROM sago007/openarena:latest
MAINTAINER poul@poulsander.com

USER root

RUN apt-get update && apt-get install --no-install-recommends -y wget unzip && \
mkdir /staging && \
cd /staging && wget http://files.poulsander.com/~poul19/public_files/oacmp-volume1-v3.zip && \
cd /staging && unzip /staging/oacmp-volume1-v3.zip -d /opt/openarena && rm /staging/oacmp-volume1-v3.zip && \
rm -rf /opt/openarena/oacmp-mod && \
rm -rf /opt/openarena/sources && \
apt-get purge -y wget unzip && \
apt-get autoremove -y && \
rm -rf /var/lib/apt/lists/*

COPY maps_dm.cfg /default_files

USER openarena
ENV OA_STARTMAP oacmpdm1
