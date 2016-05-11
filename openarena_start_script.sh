#! /bin/bash
set -euo pipefail

OPENARENA_HOME=/data/openarena
BASEOA=${OPENARENA_HOME}/baseoa
LOGROTATE_STATE=/data/logrotate

mkdir -p "${BASEOA}"

cd /default_files
ls | xargs -n1 /opt/copy_to_if_not_existing.sh "${BASEOA}"
cd /default_files2
ls | xargs -n1 /opt/copy_to_if_not_existing.sh "/data/"

if [ "$OA_LOGROTATE" = "1" ]
then
mkdir -p "${LOGROTATE_STATE}"
logrotate -s "${LOGROTATE_STATE}/state" /data/games_log.logrotate
fi

SERVER_ARGS="+set fs_homepath /data/openarena +set net_port ${OA_PORT} +exec server_config_sample.cfg +map $OA_STARTMAP"

# 1==LAN, 2==Internet
DEDICATED_ARG="+set dedicated 2"

DAEMON_ARGS="$DEDICATED_ARG $SERVER_ARGS"

DAEMON=/opt/openarena/oa_ded.x86_64

echo "Starting: $DAEMON $DAEMON_ARGS"
exec $DAEMON $DAEMON_ARGS
