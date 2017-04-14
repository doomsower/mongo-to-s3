#!/bin/bash

# Export AWS and Mongo settings into env file for cron job
printenv | grep -E "^AWS|MONGODB|S3" | sed 's/^\([a-zA-Z0-9_]*\)=\(.*\)$/export \1="\2"/g' > /root/cron_env.sh

touch /mongo_backup.log

if [ -n "${INIT_BACKUP}" ]; then
    echo "Init backup"
    /backup.sh
fi

echo "${CRON_TIME} . /root/cron_env.sh; /backup.sh >> /mongo_backup.log 2>&1" > /crontab.conf
crontab  /crontab.conf
echo "Starting cron..."
cron && tail -f /mongo_backup.log
