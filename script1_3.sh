#!/bin/bash

# What to backup:
source_dir="/home/alex/Documents"

# Where to backup to:
backup_dir="/home/alex/backup/backup.tar"

tar -cf $backup_dir -C   $source_dir .

# Only changes backup - /home/alex/backup.log

dest_dir="/var/tmp/backups"
out=$(
exec 2>&1
find $source_dir -type f -printf "%m\t" -exec md5sum {} \; >$dest_dir.tmp
diff $dest_dir $dest_dir.tmp
mv -f $dest_dir.tmp $dest_dir
)

if [ "$out" ];then
	(echo;date;echo "$out";echo) |  cat>>/home/alex/backup.log 
fi 
 
 

