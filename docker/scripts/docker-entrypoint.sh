#!/bin/bash


if [ -z "${OBJECT_STORAGE_CREDENTIALS}" ]; then
    echo "mising env variable: OBJECT_STORAGE_CREDENTIALS"
    exit 1
fi

export USERID=`echo "${OBJECT_STORAGE_CREDENTIALS}" | jq -r '.userId'`
export PASSWORD=`echo "${OBJECT_STORAGE_CREDENTIALS}" | jq -r '.password'`
export PROJECTID=`echo "${OBJECT_STORAGE_CREDENTIALS}" | jq -r '.projectId'`
export REGION=`echo "${OBJECT_STORAGE_CREDENTIALS}" | jq -r '.region'`

exec "$@"
