#!/bin/sh
#current version: cfgftp_20150105-1, last version: cfgftp_20141014-1

#DEA
logname="backup-DEA"
host="172.18.9.188"
id="deabackup"
pw="deabkup@140327"
remodir="/"
localdir="/opt/traffix/sdc/utils/system/linux/backup_and_restore"

#DRA
#logname="backup"
#host="172.18.9.188"
#id="drabackup"
#pw="drabkup@140717"
#remodir="/"
#localdir="/opt/traffix/sdc/utils/system/linux/backup_and_restore"

#DEA-splunk
host2="172.18.9.183"
logname2="message"
id2="tacm_dea"
pw2="tacm_dea@1234"
remodir2="/opt/ftp/tacm_dea/vmbackup"
localdir2="/var/log"

#DRA-splunk
#host2="172.18.9.183"
#id2="volte_dra"
#pw2="volte_dra@1234"
#remodir2="/opt/ftp/volte_dra"


tfile="/tmp_file"

ping $host -c 4 &> /dev/null
if [ ! "$?" == 0 ]; then
echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
echo "FTP host connection down" >> /tmp/uploaded_log.txt
echo "######################" >> /tmp/uploaded_log.txt
exit 0
fi

if [ ! -d "$localdir$tfile" ]; then
mkdir "$localdir$tfile"
fi

cd $localdir
filename="`ls -t $logname* | head -1`"
#find the latest backup-DEA config file from /opt/traffix/sdc/utils/system/linux/backup_and_restore

ftp_log="ftp_config_log_`hostname`_`date +%Y%m%d%H%M%S`.txt"

echo "open $host
user $id $pw
lcd $localdir
binary
cd $remodir
put $filename
bye
" | ftp -vin > $localdir$tfile/$ftp_log
echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
ls -l $filename >> /tmp/uploaded_log.txt

echo "open $host2
user $id2 $pw2
lcd $localdir$tfile
binary
cd $remodir2
put $ftp_log
bye
" | ftp -vin
cd $localdir/tmp_file
echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
ls -l >> /tmp/uploaded_log.txt

if [ ! -d "/opt/tmp/dump" ]; then
mkdir -p "/opt/tmp/dump"
fi
#cp -a $localdir/$filename /opt/tmp/dump
#config size is too big to save...

cp -a $localdir$tfile/$ftp_log /opt/tmp/dump
#ALL dump file send to /opt/tmp/dump from this version
#dump every uploaded file for keep local and monitor on /opt/tmp/dump

rm -f $localdir$tfile/*
#remove the message.log_hostname_date file we create
