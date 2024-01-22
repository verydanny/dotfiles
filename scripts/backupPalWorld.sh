#!/bin/bash

PALWORLD_DIR="$HOME/source/docker-palworld-dedicated-server/game"
BACKUP_DIR="$HOME/backup/palworld"

function backup_palworld() {
  if [[ ! -d $BACKUP_DIR ]]; then
    mkdir -p $BACKUP_DIR
  fi

  cd $PALWORLD_DIR
  tar -cf $BACKUP_DIR/archive_$(date +%Y%m%d%H%M).tar "Pal"
}

backup_palworld
