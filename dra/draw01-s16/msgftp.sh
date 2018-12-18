#!/bin/sh
#current version: msgftp_20150402-1, last version: msgftp_20141008-1
#DRA
host="172.18.9.183"
id="volte_dra"
pw="volte_dra@1234"
remodir="/opt/ftp/volte_dra"
localdir="/var/log"
logname="message"

#DEA
#host="172.18.9.183"
#logname="message"
#id="tacm_dea"
#pw="tacm_dea@1234"
#remodir="/opt/ftp/tacm_dea"
#localdir="/var/log"

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
#echo `crm status` >> $logPath
echo $localdir  >> $logPath
ls -tl $localdir/$logname* | head -6 >> $logPath
echo $localdir$tfile  >> $logPath
ls -l $localdir$tfile  >> $logPath
echo $files " files on this upload" >> $logPath
}

startFtp(){
echo "open $host
user $id $pw
lcd $localdir$tfile
binary
cd $remodir/backup
put *
bye
" | ftp -vin
echo "FTP_"`hostname`"--"$host"_"`date +%Y-%m%d-%H%M%S` >> $logPath
}

script_name="msgftp"
tfile="/tmp_file"

f1="$localdir$tfile"
#f2="$localdir/tmp_tarfile"
#f3="$localdir/tmp_tarfile2"
f4="/opt/tmp/dump/$logname"
f5="/opt/tmp/log/$script_name"
#f6="/opt/tmp/refer"
arr=(
#$f1 $f2 $f3 $f4 $f5 $f6
$f1 $f4 $f5
)

for ((a=0; a<${#arr[@]}; a++));do
tempdir="${arr[a]}"
checkDir
done


logPath=$f5/$script_name_`date +%Y-%m%d`_`hostname`.txt

cd $localdir
filename="`ls -t $logname* | head -1`"
cp -a $localdir/$filename $localdir/tmp_file/$logname".log_`hostname`_`date +%Y%m%d%H%M%S`"
#copy latest message log and rename to message.log_hostname_date

files=`ls $localdir$tfile/* 2> /dev/null | wc -l `

writeLog

startFtp


cp -a $localdir$tfile/* /opt/tmp/dump/$logname
#ALL dump file send to /opt/tmp/dump from this version
#dump every uploaded file for keep local and monitor on /opt/tmp/dump

rm -f $localdir/tmp_file/*
#remove the message.log_hostname_date file we create
