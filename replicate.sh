#!/bin/bash

# Exit when any command fails
set -e

if [ -z "$SOURCE_APP" ]
then
  echo "SOURCE_APP is not set"
  exit 1
fi

if [ -z "$SCALINGO_CLI_TOKEN" ]
then
  echo "SCALINGO_CLI_TOKEN is not set"
  exit 1
fi

if [ -z "$DATABASE_BACKUP_URL" ]
then
  echo "DATABASE_BACKUP_URL is not set"
  exit 1
fi

install-scalingo-cli
dbclient-fetcher psql

scalingo login --api-token $SCALINGO_CLI_TOKEN

ADDON_ID=`scalingo --app $SOURCE_APP addons | grep postgresql | awk -F '|' '{print $3}'`

ARCHIVE_NAME=backup.tar.gz

scalingo --app $SOURCE_APP --addon $ADDON_ID backups-download --output $ARCHIVE_NAME

BACKUP_NAME=`tar -tf $ARCHIVE_NAME | tail -n 1`

tar -C /app -xvf $ARCHIVE_NAME

pg_restore --clean --if-exists --no-owner --no-privileges --no-comments --dbname $DATABASE_BACKUP_URL /app$BACKUP_NAME
