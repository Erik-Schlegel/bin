#!/bin/sh
timeStamp=$(date +%m%d%Y_%H%M%p);

src=$1 										## e.g.: /mnt/c/Neurocloud/Dropbox/3D/Blender/Subway/
dest=$2 									## e.g.: /mnt/d/Backups/3D/Blender/Subway
excludeFromListFile=$3 		## e.g.: /home/esch/bin/backupConfig/blender.exclude

## if source directory has files newer than 4 minutes
if [ "$(find $src -mmin -4)" ]; then
	mkdir -p $dest/$timeStamp/
	rsync -aq --exclude-from=$excludeFromListFile --size-only $src $dest/$timeStamp

	## get number of folders in the dest directory
	exitingBackupFolderCount=$(find $dest -type d | wc -l);

	## 72 backups max in 6hr period ((6hr*60m)/5m interval)
	if [ $exitingBackupFolderCount -gt 72 ]; then
		oldestBackupFolder=$(find $dest -type d -printf '%T@ %p\n' | sort -n | head -n 1 | cut -d' ' -f2);
		rm -rf $oldestBackupFolder;
	fi
fi
