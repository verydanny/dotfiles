#!/bin/sh

PALWORLD_DIR="$HOME/source/docker-palworld-dedicated-server/game"
BACKUP_DIR="$HOME/backup/palworld"

function backup_palworld() {
  if [[ ! -d $BACKUP_DIR ]]; then
    mkdir -p $BACKUP_DIR
  else
    cd $PALWORLD_DIR
    tar -cf $BACKUP_DIR/archive_$(date +%Y%m%d%H%M).tar "Pal"
  fi
}

backup_palworld
