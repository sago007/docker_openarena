FROM debian:8
MAINTAINER poul@poulsander.com
ADD openarena-0.8.8.zip /staging/
ADD move_to_default_files.sh /staging/
ADD server_config_sample.cfg /default_files/
ADD create_docker_internal_script.sh /staging/
RUN /staging/create_docker_internal_script.sh
ADD move_to_if_not_existing.sh /opt/
ADD openarena_start_script.sh /opt/

VOLUME ["/data"]

EXPOSE 27960/udp 
#EXPOSE 27950/udp

USER openarena

CMD /opt/openarena_start_script.sh
