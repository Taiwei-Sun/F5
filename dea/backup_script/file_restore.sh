#!/bin/bash
# v.20180910-01
# RHEL6 REL7 is verified.
# add check file if exist at /tmp
# use file_backup.sh to backup file data
# make restore list changeable
# check tar.gz :tar -ztvf file.tar.gz
# restore
# ./$0 $1

if [ ! -f "$1" ]; then
    echo "[FAIL] Should use list file as parameter to notice path need to be backup : $0 list.log"
    exit 0
fi
if [ ! -f /tmp/file_backup_*.tar.gz ]; then
    echo "[FAIL] Should put file to /tmp as : /tmp/file_backup_*.tar.gz"
    exit 0
fi

LIST_FILE=$1
## NEW_FILE_LIST is for rm space line
NEW_LIST_FILE="/tmp/NEW_LIST_FILE_`date +%Y_%m%d_%H`.log"
sed '/^$/d' $LIST_FILE > $NEW_LIST_FILE
cd /
## check and backpup list file
for i in `cat $NEW_LIST_FILE`
do
	if [ -f "$i" ];then
	#echo $i YES
	mv $i $i.`date +%Y%m%d-%H%M`.bak
else
	echo $i NO need backup
	fi
tar -zxvf /tmp/file_backup_*.tar.gz $i
done

#cd /
#tar -zxvf /tmp/file_backup_*.tar.gz
sleep 3
echo " -- file restore finished -- "

