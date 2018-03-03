FROM debian:9
MAINTAINER poul@poulsander.com

#For development purposes it may be preferable to download the file and COPY it into the container
#COPY openarena-0.8.8.zip /staging/
COPY move_to_default_files.sh /staging/
COPY openarena_files.md5 /staging/
#Default files to be copied to /data/openarena/baseoa if not exits
COPY server_config_sample.cfg /default_files/
COPY create_docker_internal_script.sh /staging/
RUN /staging/create_docker_internal_script.sh
COPY copy_to_if_not_existing.sh /opt/
COPY openarena_start_script.sh /opt/

#All persistant data is stored under /data. Both config and logs
VOLUME ["/data"]

#OpenArena needs this one port.
EXPOSE 27960/udp

#This is environments you can give to Docker.
#OA_STARTMAP sets the first map to load. This is required because the server does not start until a map is loaded.
ENV OA_STARTMAP dm4ish
ENV OA_PORT 27960
ENV OA_ROTATE_LOGS 1

USER openarena

#This is the default start path
CMD /opt/openarena_start_script.sh

#Can be started like this:
#docker run -it -e "OA_STARTMAP=dm4ish" -e "OA_PORT=27960" --rm -p 27960:27960/udp -v openarena_data:/data sago007/openarena

#Be warned that the port number must be changed in all three places for the server to appear in the serverlist (2016-05-02). I have not examinated if this is a bug or design flaw in ioquake3 or Docker but the server port is not reported correctly to the master server.

#To change the config you can start a bash shell and edit the config:
#Start with: docker run -it --rm -v openarena_data:/data --user 1000 sago007/openarena bash
#And then execute:
#nano /data/openarena/baseoa/server_config_sample.cfg
