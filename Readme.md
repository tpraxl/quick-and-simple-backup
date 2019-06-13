# Quick and simple Backup

Lean-and-mean, simple and quick backup solution for automated filebased backup of folders.  
You define the folders to backup and the backup-target by adding a symlink.  

To add a folder to your backup, just `ln -sfn target-folder-name /path/to/your/folder`.

The execution can be scheduled by using cronjobs.

It will create date based folders, like 2019-06-13 inside the backup target folder and it won't perform housekeeping (e.g. delete old folders). So from time to time, you need to manually cleanup your backup target.

One day, you will want a more sophisticated solution.  
See https://www.borgbackup.org then, for example.

## Requirements

Please make sure that the following requirements are installed:

* libnotify-bin (for notify-send)
* rsync

### Requirements Installation for Debian, Ubuntu and Mint

Install them by invoking `sudo apt install libnotify-bin rsync` on the terminal.

## Setup 

Download [https://raw.githubusercontent.com/tpraxl/quick-and-simple-backup/master/backup.sh](backup.sh) and make it executable.

Add a backup-enabled folder and symlink the backup target location.

For each folder, you want to backup, add a symlink to the backup-enabled folder.

### Example setup

#### Download and make executable

Say your user is `christoph`. Then you might want to copy it to `/home/christoph/quick-and-simple-backup`.

```bash
$ mkdir /home/christoph/quick-and-simple-backup
$ cd /home/christoph/quick-and-simple-backup
$ wget https://raw.githubusercontent.com/tpraxl/quick-and-simple-backup/master/backup.sh
$ chmod u+x backup.sh
```

#### Define the backup target

Say your backup location is `/media/christoph/BACKUP-DRIVE/`

```bash
$ ln --symbolic --no-dereference --force backup /media/christoph/BACKUP-DRIVE/
```

#### Prepare backup-enabled folder

```bash
$ mkdir backup-enabled
$ cd backup-enabled
``` 

#### Add a folder to the backup

Define the folder `/home/christoph/Documents/important` as a backup source. It will be backed up as `important-documents`:

```bash
$ cd /home/christoph/quick-and-simple-backup/backup-enabled
$ ln -sfn important-documents /home/christoph/Documents/important
```

### Cron entry for automatic backup

Add the following entry to your crontab. 

To do so, type `crontab -e` and hit enter. 

Add the following line (substitute the path `/home/christoph/quick-and-simple-backup` with your actual absolute path to `backup.sh`).

```
49 * * * * export DISPLAY=:0.0 && /home/christoph/quick-and-simple-backup/backup.sh
```

This setting will perform your backup once an hour at minute 49. 

See http://cheat.sh/crontab or `man crontab` for more info about configuring your recurring tasks.

### Editing, saving and exiting your editor depends on your editor. 

#### nano

If you use nano, then simply type, hit CTRL+O followed by CTRL+X.

#### vi / vim

If you use vi or vim, then hit `i` to enter insert mode. Enter the line.
Type ESC to escape insert mode, then `:x` to save and exit.



