
#!/bin/sh
#current version: autocsvftp_20150116-1, last version: N/A

#DRA
host="172.27.21.120"
#logname=""
id="ftpdea"
pw="user_0909"
remodir="/LTE_Core/DRA"
localdir="/opt/traffix/autoreporting"

#DEA
#host="172.27.21.120"
#logname=""
#id="ftpdea"
#pw="user_0909"
#remodir="/LTE_Core/DEA"
#localdir="/opt/traffix/autoreporting"

tfile="/tmp_file"

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
cp -a $localdir/$line $localdir/tmp_file/.
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
#rm -f $localdir/tmp_file/*

if [ ! -d "/opt/tmp/dump" ]; then
mkdir -p "/opt/tmp/dump"
fi
cp -a $localdir/tmp_file/* /opt/tmp/dump
#ALL dump file send to /opt/tmp/dump from this version
#dump every uploaded file for keep local and monitor on /opt/tmp/dump

rm -f $localdir/tmp_file/*
#remove the autoreporting_we_copy file we create
