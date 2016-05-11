#! /bin/bash
set -euo pipefail

OPENARENA_HOME=/data/openarena
BASEOA=${OPENARENA_HOME}/baseoa
LOGFILE="$BASEOA/games.log"

mkdir -p "${BASEOA}"

cd /default_files
ls | xargs -n1 /opt/copy_to_if_not_existing.sh "${BASEOA}"

if [ "$OA_ROTATE_LOGS" = "1" ] && [ -f "$LOGFILE" ]
then
  NEWLOGFILENAME="$LOGFILE.$(date --iso-8601).gz"
  CURRENT_SIZE=$(du -k "$LOGFILE" | cut -f 1)
  if ! [ -f "$NEWLOGFILENAME" ] && [ $CURRENT_SIZE -gt 50000 ]
  then
    gzip < "$LOGFILE" > ${NEWLOGFILENAME}
    > "$LOGFILE" # Truncates file
  fi
fi

SERVER_ARGS="+set fs_homepath /data/openarena +set net_port ${OA_PORT} +exec server_config_sample.cfg +map $OA_STARTMAP"

# 1==LAN, 2==Internet
DEDICATED_ARG="+set dedicated 2"

DAEMON_ARGS="$DEDICATED_ARG $SERVER_ARGS"

DAEMON=/opt/openarena/oa_ded.x86_64

echo "Starting: $DAEMON $DAEMON_ARGS"
exec $DAEMON $DAEMON_ARGS
