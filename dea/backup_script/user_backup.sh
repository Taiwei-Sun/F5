#!/bin/bash
# v.20180908-01
# this version will check if password exist first, then tar its home folder
# RHEL6 REL7 is verified.
# check tar.gz :tar -ztvf file.tar.gz
# use user_restore.sh to restore user data

_P=/tmp/user_backup
rm -rf $_P
mkdir -p $_P
#export UGIDLIMIT=500 # traffix UID is 500, so escape it.
export UGIDLIMIT=501
awk -v LIMIT=$UGIDLIMIT -F: '($3>=LIMIT) && ($3!=65534)' /etc/passwd > $_P/passwd.mig
awk -v LIMIT=$UGIDLIMIT -F: '($3>=LIMIT) && ($3!=65534)' /etc/group > $_P/group.mig
#awk -v LIMIT=$UGIDLIMIT -F: '($3>=LIMIT) && ($3!=65534) {print $1}' /etc/passwd | tee – |egrep -f – /etc/shadow > $_P/shadow.mig
awk -v LIMIT=$UGIDLIMIT -F: '($3>=LIMIT) && ($3!=65534) {print $1}' /etc/passwd | tee - |egrep -f - /etc/shadow > $_P/shadow.mig
cp /etc/gshadow $_P/gshadow.mig
#tar -zcvpf $_P/home.tar.gz /home
## NEW_FILE_LIST keep this file list when restore files
NEW_LIST_FILE="/tmp/user_list_`hostname`_`date +%Y-%m-%d_%H`.log"
cat /dev/null > $NEW_LIST_FILE

## check if backpup list file exist
for i in `cat /tmp/user_backup/passwd.mig | awk  -F ":" '{print $6}'`
do
	if [ ! -d "$i" ];then
	echo NOT found user $i for backup
	else
	echo $i >>  $NEW_LIST_FILE
	fi
done

tar -zcpPf $_P/home.tar.gz `cat $NEW_LIST_FILE`
tar -zcpPf /tmp/user_backup_`hostname`_`date +%Y-%m-%d`.tar.gz /tmp/user_backup
