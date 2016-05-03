#! /bin/bash
set -euo pipefail

#The whole purpose of this script is to have an readable alternative that can build the image in one go

apt-get update && apt-get install -y wget unzip nano
mkdir -p /opt && mkdir -p /staging/map_lists && mkdir -p /default_files
adduser --disabled-password --gecos "OpenArena user" openarena
mkdir -p /data

#It is possible that openarena-0.8.8 was added in the Docker file if not we download it from the net
if ! [ -f "/staging/openarena-0.8.8.zip" ]
then
cd /staging && wget http://download.tuxfamily.org/openarena/rel/088/openarena-0.8.8.zip -O openarena-0.8.8.zip
fi 


cd /staging && mv openarena-0.8.8.zip openarena.zip
cd /staging && unzip /staging/openarena.zip -d /opt && rm /staging/openarena.zip
mv /opt/openarena-0.8.8 /opt/openarena
cd /staging/map_lists && unzip /opt/openarena/baseoa/pak6-patch088.pk3 && ls *.org | xargs -n1 /staging/move_to_default_files.sh

chown openarena.openarena /data
chown -R openarena.openarena /opt
chown -R openarena.openarena /opt
chown -R openarena.openarena /default_files

apt-get purge -y wget unzip
apt-get autoremove -y
rm -rf /staging
rm -rf /tmp/* /var/tmp/*
cd /opt/openarena
rm *.dll
rm *.exe
rm *.i386
rm -rf __MACOSX
rm -rf OpenArena.app
rm -rf "OpenArena 0.8.8 r28.app"
rm openarena.x86_64
