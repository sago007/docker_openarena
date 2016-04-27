#! /bin/bash
set -euo pipefail

#The whole purpose of this script is to have an readable alternative that can build the image in one go

apt-get update && apt-get install -y wget unzip
mkdir -p /opt && mkdir -p /staging/map_lists && mkdir -p /default_files
adduser --disabled-password --gecos "OpenArena user" openarena
mkdir -p /data

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
