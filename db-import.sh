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
UPLOADS_PATH=$(echo "$UPLOADS_PATH")

# 1. Copy db backup, and uploads zip from Dropbox
cp "${DROPBOX_PATH}${SQL_FILENAME}.sql" "${PROJECT_PATH}"

if [ ${INCLUDE_UPLOADS_IN_EXPORT} ]
then
	cp "${DROPBOX_PATH}${SQL_FILENAME}-uploads.zip" "${PROJECT_PATH}"
fi

# 2. Import db backups and uploads zip
ssh vagrant@${VVV_IP} "cd ${VVV_PATH} && wp db import --color ${SQL_FILENAME}.sql"

if [ ${INCLUDE_UPLOADS_IN_EXPORT} ]
then
	ssh vagrant@${VVV_IP} "cd ${VVV_PATH} && rm -rf web/app/uploads && unzip ${SQL_FILENAME}-uploads.zip -d . && cd ${UPLOADS_PATH} && touch .gitkeep && chmod 644 .gitkeep"
fi

# 3. Remove temp zip and sql-files
rm -rf "${PROJECT_PATH}${SQL_FILENAME}.sql"

if [ ${INCLUDE_UPLOADS_IN_EXPORT} ]
then
	rm -rf "${PROJECT_PATH}${SQL_FILENAME}-uploads.zip"
fi
