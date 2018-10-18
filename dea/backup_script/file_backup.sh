#!/bin/bash
# v.20180907-1
# RHEL6 REL7 is verified.
# use file_restore.sh /tmp/file_backup_lbsx1_list_2018-08-14_02.log to restore file data
# check tar.gz :tar -ztvf file.tar.gz
# backup
# ./file_backup.sh file_list_all.log

if [ "`id -un`" != "root" -a "`id -un`" != "simon" ]; then
    echo "[FAIL] Should be executed by root"
    exit 0
fi

if [ ! -f "$1" ]; then
    echo "[FAIL] Should use list file as parameter to notice path need to be backup : $0 list.log"
    exit 0
fi

LIST_FILE=$1
## NEW_FILE_LIST keep this file list when restore files
NEW_LIST_FILE="/tmp/file_list_`hostname`_`date +%Y-%m-%d_%H`.log"
cat /dev/null > $NEW_LIST_FILE
 
## check if backpup list file exist
for i in `cat $LIST_FILE`
do
	if [ ! -f "$i" ];then
	echo NOT found $i for backup
	else
	echo $i >>  $NEW_LIST_FILE
	fi
done

bak_file=file_backup_`hostname`_`date +%Y-%m-%d`.tar.gz
tar -zcpPf /tmp/$bak_file `cat $NEW_LIST_FILE`
#tar -zcpPf /tmp/$bak_file `cat $NEW_LIST_FILE` > /dev/null 2>&1
_all=`cat $LIST_FILE | wc -l`
_got=`cat $NEW_LIST_FILE | wc -l`
echo -e '\n\n##########\n'
echo backup file $_got / $_all at `hostname`
echo -e '\nDO not forget to collect these two files'
echo /tmp/$bak_file
echo $NEW_LIST_FILE
echo -e '\n##########\n'








