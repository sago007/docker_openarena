#! /bin/bash
set -euo pipefail

OPENARENA_HOME=/data/openarena
BASEOA=${OPENARENA_HOME}/baseoa

mkdir -p "${BASEOA}"

cd /default_files
ls | xargs -n1 /opt/move_to_if_not_existing.sh "${BASEOA}"

SERVER_ARGS="+set fs_homepath /data/openarena +exec server_config_sample.cfg $OA_STARTARGS +map $OA_STARTMAP"

# 1==LAN, 2==Internet
DEDICATED_ARG="+set dedicated 2"

DAEMON_ARGS="$DEDICATED_ARG $SERVER_ARGS"

DAEMON=/opt/openarena/oa_ded.x86_64

exec $DAEMON $DAEMON_ARGS
