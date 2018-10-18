#!/bin/bash
# v.20180910-01
# RHEL6 RHEL7 is verified.
# add check file if exist at /tmp
# use user_backup.sh to backup user data
# suggest use on clean OS
##
if [ "`id -un`" != "root" -a "`id -un`" != "simon" ]; then
    echo "[FAIL] Should be executed by root"
    exit 0
fi
if [  -f "$1" ]; then
    echo "[FAIL] No need parameter "
    exit 0
fi
if [ ! -f /tmp/user_backup_*.tar.gz ]; then
    echo "[FAIL] Should put file to /tmp as : /tmp/user_backup_*.tar.gz"
    exit 0
fi
cp /etc/passwd /etc/passwd.`date +%Y%m%d-%H%M`.bak 
cp /etc/shadow /etc/shadow.`date +%Y%m%d-%H%M`.bak
cp /etc/group /etc/group.`date +%Y%m%d-%H%M`.bak
cp /etc/gshadow /etc/gshadow.`date +%Y%m%d-%H%M`.bak

cd /tmp
tar -zxpPf user_backup_*.tar.gz

cd /tmp/user_backup
cat passwd.mig >> /etc/passwd
cat group.mig >> /etc/group
cat shadow.mig >> /etc/shadow
cp gshadow.mig /etc/gshadow

cd /
tar -zxvf /tmp/user_backup/home.tar.gz
sleep 3
echo " -- user restore finished -- "
echo " -- suggest to reboot ASAP -- "

