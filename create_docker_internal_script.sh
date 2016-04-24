#! /bin/bash
set -e

#The whole purpose of this script is to have an readable alternative that can build the image in one go

apt-get update && apt-get install -y wget unzip
mkdir -p /opt && mkdir -p /staging/map_lists && mkdir -p /default_files
adduser --disabled-password --gecos "OpenArena user" openarena
mkdir -p /data
chown openarena.openarena /data

cd /staging && mv openarena-0.8.8-repack.zip openarena.zip
cd /staging && unzip /staging/openarena.zip -d /opt && rm /staging/openarena.zip
cd /staging/map_lists && unzip /opt/openarena-0.8.8/baseoa/pak6-patch088.pk3 && ls *.org | xargs -n1 /staging/move_to_default_files.sh

apt-get purge -y wget unzip
apt-get autoremove -y
rm -rf /staging
rm -rf /tmp/* /var/tmp/*
