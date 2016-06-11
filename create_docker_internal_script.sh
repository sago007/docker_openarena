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
cd /staging && wget http://files.poulsander.com/~poul19/public_files/oa/dev088/openarena_engine_2016-04-23_2d555ac662aef135c47d473d1d61a99b69cad14a.zip
#This can be used to get the gamecode. Not needed at the moment.
cd /staging && wget http://files.poulsander.com/~poul19/public_files/oa/dev088/openarena_gamecode_2015-10-01_b767acae0de31968331f9182c6afbab1376954b8.zip

#The following lines can be used to generate the md5sums
#md5sum openarena_engine_2016-04-23_2d555ac662aef135c47d473d1d61a99b69cad14a.zip
#md5sum openarena_gamecode_2015-10-01_b767acae0de31968331f9182c6afbab1376954b8.zip
#md5sum openarena-0.8.8.zip
md5sum --check openarena_files.md5

cd /staging && mv openarena-0.8.8.zip openarena.zip
cd /staging && unzip /staging/openarena.zip -d /opt && rm /staging/openarena.zip
cd /staging && unzip openarena_engine*.zip && unzip openarena_gamecode*.zip
mv /opt/openarena-0.8.8 /opt/openarena
cd /staging/map_lists && unzip /opt/openarena/baseoa/pak6-patch088.pk3 && ls *.org | xargs -n1 /staging/move_to_default_files.sh

chown openarena.openarena /data
chown -R openarena.openarena /opt
chown -R openarena.openarena /default_files

apt-get purge -y wget unzip
apt-get autoremove -y
cd /opt/openarena
rm *.dll
rm *.exe
rm *.i386
rm -rf __MACOSX
rm -rf OpenArena.app
rm -rf "OpenArena 0.8.8 r28.app"
rm *.x86_64
mv /staging/openarena_engine*/oa_ded.x86_64 ./
chown -R openarena.openarena /opt
chmod o+r -R /opt
chmod o+r -R /default_files
find /opt -type d -execdir chmod 755 {} +

rm -rf /staging
rm -rf /tmp/* /var/tmp/*
