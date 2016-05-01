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

#OpenArena needs this one port. It can be remapped in Docker
EXPOSE 27960/udp 

#This is environments you can give to Docker.
#OA_STARTMAP sets the first map to load. This is required because the server does not start until a map is loaded.
ENV OA_STARTMAP oasago2

USER openarena

#This is the default start path
CMD /opt/openarena_start_script.sh

#Can be started like this:
#docker run -it -e "OA_STARTMAP=dm4ish" --rm -p 27961:27960/udp -v openarena_data:/data sago007/openarena

#To change the config you can start a bash shell, install vim (or other editor) and edit the config:
#Start with: docker run -it --rm -v openarena_data:/data --user 0 sago007/openarena bash
#And then execute:
#apt-get install -y vim
#vim /data/openarena/baseoa/server_config_sample.cfg