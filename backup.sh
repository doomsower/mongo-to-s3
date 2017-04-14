#!/bin/bash

TIMESTAMP=`date +%Y-%m-%d--%H-%M-%S`
BACKUP_NAME=${MONGODB_DB}_${TIMESTAMP}.tar.gz
BACKUP_TGZ=/backup/${BACKUP_NAME}
BACKUP_DIR=/backup/${MONGODB_DB}/
S3PATH="s3://$S3_BUCKET/$BACKUP_FOLDER"
S3BACKUP=${S3PATH}${BACKUP_NAME}
S3LATEST=${S3PATH}${MONGODB_DB}_latest.tar.gz

if     mongodump --host ${MONGODB_HOST} --port ${MONGODB_PORT} --db ${MONGODB_DB} --out /backup \
    && tar czf ${BACKUP_TGZ} ${BACKUP_DIR} \
    && aws s3 cp ${BACKUP_TGZ} ${S3BACKUP} \
    && aws s3 cp ${S3BACKUP} ${S3LATEST}
then
   echo "Backup succeeded"
else
   echo "Backup failed"
fi

rm -rf ${BACKUP_DIR}
rm ${BACKUP_TGZ}
