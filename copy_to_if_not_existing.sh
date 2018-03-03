#! /bin/bash
set -euo pipefail

DESTDIR=$1
FILENAME=$2
DESTFILE=${DESTDIR}/${FILENAME}

if [ -f "$DESTFILE" ]
then
  echo "$DESTFILE exists"
  exit 0
fi

cp "$FILENAME" "$DESTFILE"
