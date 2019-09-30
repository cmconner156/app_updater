#!/bin/bash

APP_UPDATE_DIR=$1

if [[ -z ${APP_UPDATE_DIR} ]]
then
  APP_UPDATE_DIR=/app_update
fi

DEST_UPDATE_DIR=$2

if [[ -z ${DEST_UPDATE_DIR} ]]
then
  DEST_UPDATE_DIR=/dest_update
fi

BACKUP_DIR=$3

if [[ -z ${BACKUP_DIR} ]]
then
  BACKUP_DIR=/backups
fi

RESTART_SERVICE=$4

while [ 1 ]
do

  if [[ -f ${APP_UPDATE_DIR}/done ]]
  then
    DATE=$(date '+%Y%m%d-%H%M%S')
    echo "Done flag found ${DATE}"
    mkdir ${BACKUP_DIR}/${DATE}
    mv ${APP_UPDATE_DIR}/* ${BACKUP_DIR}/${DATE}
    cd ${DEST_UPDATE_DIR}
    /bin/cp -f ${BACKUP_DIR}/${DATE}/* .
    rm -f done

    for x in $(ls *python-37*)
    do
      echo $x
      LINK_NAME=$(echo $x | awk -F\.cpython '{print $1".pyc"}')
      echo $LINK_NAME
      if [[ ! -f ${LINK_NAME} ]]
      then
        echo "MISSING ${LINK_NAME}"
        echo "LINKING ${LINK_NAME}"
        ln -s $x ${LINK_NAME}
      fi
    done
#    if [[ ! ${RESTART_SERVICE} =~ .*NONE.* ]]
#    then
#      systemctl restart ${RESTART_SERVICE}
#    fi

  fi
done
