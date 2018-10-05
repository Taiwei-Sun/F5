#!/bin/sh
host="172.18.9.183"


logname="message"
#logname="webui"

id="tacm_dea"
pw="tacm_dea@1234"
#remodir="/tmp"
remodir="/opt/ftp/tacm_dea"

localdir="/var/log"
#localdir="/opt/traffix/sdc/logs/webui"
tfile="/tmp_file"
#mkdir $localdir/tmp_file

if [ ! -d "$localdir$tfile" ]; then
mkdir "$localdir$tfile"
fi

cd $localdir
filename="`ls -t $logname* | head -1`"
cp -a $localdir/$filename $localdir/tmp_file/$logname".log_`hostname`_`date +%Y%m%d%H%M%S`"

echo "open $host
user $id $pw
lcd $localdir/tmp_file
binary
cd $remodir/backup
put *
bye
" | ftp -vin
cd $localdir/tmp_file
echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
ls -l >> /tmp/uploaded_log.txt
rm -f $localdir/tmp_file/*