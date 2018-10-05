#!/bin/sh
#host="192.168.243.128"
host="172.18.9.183 "

#logname="message"
logname="webui"

id="tacm_dea"
pw="tacm_dea@1234"
#id="q1"
#pw="111111"
#remodir="/tmp"
remodir="/opt/ftp/tacm_dea/"

#localdir="/home/test/newest_file"
#localdir="/var/log"
localdir="/opt/traffix/sdc/logs/webui"
tfile="/tmp_file"
#mkdir $localdir/tmp_file

if [ ! -d "$localdir$tfile" ]; then
mkdir "$localdir$tfile"
fi

cd $localdir
filename1="`ls -t $logname.log* | head -2 | head -1`"

filename2="`ls -t $logname.log* | head -2 | tail -1`"

datime="`date -d '10 minutes ago' +%F\ %H:%M | cut -c 1-15`"

#cat $filename2 $filename1 | grep `date -d '4 months ago' +%F` >> $localdir$tfile/$logname".log_`hostname`_`date +%Y%m%d%H%M%S`"

if cat $filename2 $filename1 | grep "$datime" &> /dev/null; then

cat $filename2 $filename1 | grep "$datime" >> $localdir$tfile/$logname".log_`hostname`_`date +%Y%m%d%H%M%S`"
#cp -a  grep10mins.log $localdir$tfile/$logname".log_`hostname`_`date +%Y%m%d%H%M%S`"
#rm -f  grep10mins.log
else touch $localdir/tmp_file/$logname".log_`hostname`_`date +%Y%m%d%H%M%S`"
fi
echo "open $host
user $id $pw
lcd $localdir/tmp_file
binary
cd $remodir/webui
put *
bye
" | ftp -vin
cd $localdir/tmp_file
echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
ls -l >> /tmp/uploaded_log.txt
rm -f $localdir/tmp_file/*
