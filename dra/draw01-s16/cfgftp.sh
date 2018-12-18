#!/bin/sh
#current version: cfgftp_20150401-1, last version: cfgftp_20150105-1

#DEA
#logname="backup-DEA"
#host="172.18.9.188"
#id="deabackup"
#pw="deabkup@140327"
#remodir="/"
#localdir="/opt/traffix/sdc/utils/system/linux/backup_and_restore"

#DRA
logname="backup"
host="172.18.9.188"
id="drabackup"
pw="drabkup@140717"
remodir="/"
localdir="/opt/traffix/sdc/utils/system/linux/backup_and_restore"

#DEA-splunk
#host2="172.18.9.183"
#logname2="message"
#id2="tacm_dea"
#pw2="tacm_dea@1234"
#remodir2="/opt/ftp/tacm_dea"
#localdir2="/var/log"

#DRA-splunk
host2="172.18.9.183"
id2="volte_dra"
pw2="volte_dra@1234"
remodir2="/opt/ftp/volte_dra"

#This function is for creating directory
checkDir(){
if [ ! -d $tempdir ]; then
mkdir -p $tempdir
#echo "No" $tempdir
#else
#echo "already got"$tempdir
fi
}


#This function for write log
writeLog(){
echo "##### this log start #################" >> $logPath
echo `hostname`_`date +%Y-%m%d-%H%M%S` >> $logPath
echo "Here the script :"$script_name   >> $logPath
echo $localdir  >> $logPath
ls -tl $localdir | head -6 >> $logPath
echo $localdir$tfile  >> $logPath
ls -l $localdir$tfile  >> $logPath
echo $files " files on this upload" >> $logPath
}

#This function for ping test
ping_ftp(){
ping $host -c 4 &> /dev/null
if [ ! "$?" == 0 ]; then
echo `hostname`_`date +%Y-%m%d-%H%M%S` >> $logPath
echo "FTP host connection down" >> $logPath
echo "######################" >> $logPath
exit 0
fi
}

script_name="cfgftp"
tfile="/tmp_file"

f1="$localdir$tfile"
#f2="$localdir/tmp_tarfile"
#f3="$localdir/tmp_tarfile2"
f4="/opt/tmp/dump/$logname"
f5="/opt/tmp/log/$script_name"
#f6="/opt/tmp/refer"
arr=(
$f1 $f4 $f5
)

for ((a=0; a<${#arr[@]}; a++));do
tempdir="${arr[a]}"
checkDir
done

logPath=$f5/$script_name_`date +%Y-%m%d`_`hostname`.txt

#writeLog
ping_ftp

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
#echo "FTP_Configuration_"`hostname`"--"$host"_"`date +%Y-%m%d-%H%M%S` >> $logPath


echo "open $host2
user $id2 $pw2
lcd $localdir$tfile
binary
cd $remodir2
put $ftp_log
bye
" | ftp -vin
cd $localdir/tmp_file
#echo "ftp_config_log_"`hostname`"--"$host2"_"`date +%Y-%m%d-%H%M%S` >> $logPath

files=`ls $localdir$tfile/* 2> /dev/null | wc -l `

writeLog
echo "FTP_Configuration_"`hostname`"--"$host"_"`date +%Y-%m%d-%H%M%S` >> $logPath
echo "ftp_config_log_"`hostname`"--"$host2"_"`date +%Y-%m%d-%H%M%S` >> $logPath


#cp -a $localdir/$filename /opt/tmp/dump
#config size is too big to save...

cp -a $localdir$tfile/$ftp_log /opt/tmp/dump/$logname/
#ALL dump file send to /opt/tmp/dump from this version
#dump every uploaded file for keep local and monitor on /opt/tmp/dump

rm -f $localdir$tfile/*
#remove the message.log_hostname_date file we create
