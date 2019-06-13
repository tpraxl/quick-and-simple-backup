#!/usr/bin/env bash

# Requires 
# * libnotify-bin for notify-send
# * rsync

# Perform regular backups (every hour) with crontab -e
# 17 * * * * export DISPLAY=:0.0 && /home/user/backup-solution/backup.sh

# Define backup sources by ln -sn mysource backup-enabled/mysource

# Backups will be made into the backup folder. If you wish to backup to another location, 
# remove the backup folder and ln -sn yourtarget backup

# * globs hidden files as well and hides . and ..
# turning that on
shopt -s dotglob

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
TARGET_ROOT=$(readlink -f "${SCRIPT_DIR}/backup")
TARGET_RELATIVE=$(date +"%Y-%m-%d")
TARGET="${TARGET_ROOT}/${TARGET_RELATIVE}"
BACKUP_ENABLED="${SCRIPT_DIR}/backup-enabled"

echo "Backup target: ${TARGET}"

cd "${BACKUP_ENABLED}"

for f in * ; do
	# reading the symlink source and using that as the backup source
	SOURCE=$(readlink -f "${f}")
	echo "Backing up ${SOURCE}"
	rsync -rav "${SOURCE}" "${TARGET}"
done

notify-send -a "Backup" "Backup done"
