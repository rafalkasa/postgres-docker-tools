#! /bin/sh

set -e

if [ "${S3_S3V4}" = "yes" ]; then
    aws configure set default.s3.signature_version s3v4
fi

if [ "${SCHEDULE}" = "**None**" ]; then
  bash backup.sh
elif [ "${SCHEDULE}" = "RESTORE" ]; then
  bash restore.sh
else
  exec go-cron "$SCHEDULE" /bin/bash backup.sh
fi