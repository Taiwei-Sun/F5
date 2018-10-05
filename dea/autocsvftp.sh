#!/bin/sh
host="172.27.21.120"
#host="172.18.9.188"
#host="192.168.243.128"
#host="172.18.9.183 "


#logname="message"
#logname="webui"
#logname="backup-DEA"

id="ftpdea"
pw="user_0909"
#remodir="/tmp"
remodir="/LTE_Core/DEA"

#localdir="/var/log"
#localdir="/opt/traffix/sdc/logs/webui"
#localdir="/opt/traffix/sdc/utils/system/linux/backup_and_restore"
localdir="/opt/traffix/autoreporting"
tfile="/tmp_file"
#mkdir $localdir/tmp_file

if [ ! -d "$localdir$tfile" ]; then
mkdir "$localdir$tfile"
fi

cd $localdir

TS=`date +%Y%m%d`
ls -t ./*$TS* > /tmp/autocsvlist.log

if [ ! -s /tmp/autocsvlist.log ] ; then
echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
echo No such file found !!  >> /tmp/uploaded_log.txt
echo "######################" >> /tmp/uploaded_log.txt

exit 0
fi


cat /tmp/autocsvlist.log | while read line
do

#filename="`ls -t $logname* | head -1`"
cp -a $localdir/$line $localdir/tmp_file/
#cp -a $localdir/$filename $localdir/tmp_file/$filename
done

echo "open $host
user $id $pw
lcd $localdir$tfile
binary
cd $remodir
mput *
bye
" | ftp -vin
cd $localdir$tfile
echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
ls -l >> /tmp/uploaded_log.txt
#rm -f /tmp/autocsvlist.log
rm -f $localdir/tmp_file/*
