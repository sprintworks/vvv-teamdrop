#! /bin/bash

# Read .env file
source .env

# Settings and paths
VVV_IP=$(echo "$VVV_IP")
USERNAME=$USER;
PROJECT_PATH=$(echo "$PROJECT_PATH")
VVV_PATH=$(echo "$VVV_PATH")
DROPBOX_PATH=$(echo "$DROPBOX_PATH")
SQL_FILENAME=$(echo "$SQL_FILENAME")
INCLUDE_UPLOADS_IN_EXPORT=$(echo "$INCLUDE_UPLOADS_IN_EXPORT")

# 1. Make db backups and uploads zip
ssh vagrant@${VVV_IP} "cd ${VVV_PATH} && wp db export --color ${SQL_FILENAME}.sql"

if ${INCLUDE_UPLOADS_IN_EXPORT}
then
    ssh vagrant@${VVV_IP} "cd ${VVV_PATH} && zip -r ${SQL_FILENAME}-uploads.zip web/app/uploads"
fi

# 2. Copy db backup to Dropbox
cp "${PROJECT_PATH}${SQL_FILENAME}.sql" "${DROPBOX_PATH}"

if [ ${INCLUDE_UPLOADS_IN_EXPORT} ]
then
    cp "${PROJECT_PATH}${SQL_FILENAME}-uploads.zip" "${DROPBOX_PATH}"
fi

# 3. Remove zip and sql-file
rm -rf "${PROJECT_PATH}${SQL_FILENAME}.sql"

if [ ${INCLUDE_UPLOADS_IN_EXPORT} ]
then
    rm -rf "${PROJECT_PATH}${SQL_FILENAME}-uploads.zip"
fi
