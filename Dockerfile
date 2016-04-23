FROM ubuntu:14.04
RUN apt-get update && apt-get install -y wget unzip logrotate
RUN mkdir -p /opt && mkdir -p /staging/map_lists && mkdir -p /default_files
RUN adduser --disabled-password --gecos "OpenArena user" openarena
ADD openarena-0.8.8-repack.zip /staging/
ADD move_to_default_files.sh /staging/
ADD server_config_sample.cfg /default_files/
RUN cd /staging && mv openarena-0.8.8-repack.zip openarena.zip
RUN cd /staging && unzip /staging/openarena.zip -d /opt && rm /staging/openarena.zip
RUN cd /staging/map_lists && unzip /opt/openarena-0.8.8/baseoa/pak6-patch088.pk3 && ls *.org | xargs -n1 /staging/move_to_default_files.sh

RUN rm -rf /staging
RUN rm -rf /tmp/* /var/tmp/*

VOLUME ["/data"]

EXPOSE 27960/udp 
EXPOSE 27950/udp
