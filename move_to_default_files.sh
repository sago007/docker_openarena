#! /bin/bash
set -e

mv "$1" "/default_files/${1%.*}"
