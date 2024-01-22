#!/bin/bash

PALWORLD_DIR="$HOME/source/docker-palworld-dedicated-server/game"
BACKUP_DIR="$HOME/backup/palworld"

function backup_palworld() {
  if [[ ! -d $BACKUP_DIR ]]; then
    mkdir -p $BACKUP_DIR
  fi

  # Backup palworld dir
  cd $PALWORLD_DIR
  tar -cf - "Pal" | lz4 > "$BACKUP_DIR/archive_$(date +%Y%m%d%H%M).tar.lz4"

  # Delete backups older than 3 hours, we have limited space
  find "$BACKUP_DIR" -type f -mmin +180 -exec rm {} \;
}

function restore_backup() {
  
  latest_backup=$(ls -t $BACKUP_DIR/*.tar.lz4 | head -n 1)

  if [[ -f "$latest_backup" ]]; then
    lz4 -d "$latest_backup" | tar -xf - -C "$PALWORLD_DIR"
    echo "Restoration complete from backup: $latest_backup"
  else
    echo "No backup file found in $BACKUP_DIR"
  fi
}

# restore_backup
backup_palworld

