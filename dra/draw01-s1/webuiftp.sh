#!/bin/sh
#current version: webguiftp_20150401-1, last version: webguiftp_20141008-1

#DEA
#host="172.18.9.183"
#id="tacm_dea"
#pw="tacm_dea@1234"
#remodir="/opt/ftp/tacm_dea"
#localdir="/opt/traffix/sdc/logs/webui"

#DRA
host="172.18.9.183"
id="volte_dra"
pw="volte_dra@1234"
remodir=" /opt/ftp/volte_dra"
localdir="/opt/traffix/sdc/logs/webui"
logname="webui"
#logname="message"

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
#echo `crm status` >> $logPath
echo $localdir  >> $logPath
ls -tl $localdir/$logname* | head -6 >> $logPath
echo $localdir$tfile  >> $logPath
ls -l $localdir$tfile  >> $logPath
echo $files " files on this upload" >> $logPath
}

startFtp(){
#for i in TAC QA;do
#host="host$i"
#id="id$i"
#pw="pw$i"
#remodir="remodir$i"
echo "open $host
user $id $pw
lcd $localdir$tfile
binary
cd $remodir/webui
#mput *
put *
bye
" | ftp -vin
echo "FTP_"`hostname`"--"$host"_"`date +%Y-%m%d-%H%M%S` >> $logPath
#done
}

script_name="webuiftp"
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
filename1="`ls -t $logname.log* | head -2 | head -1`"

filename2="`ls -t $logname.log* | head -2 | tail -1`"

datime="`date -d '10 minutes ago' +%F\ %H:%M | cut -c 1-15`"
#this is to filter the webui.log by 10 mins ago date formate ex: 2014-08-21 13:5

if cat $filename2 $filename1 | grep "$datime" &> /dev/null; then
#use &> /dev/null to avoid error messages

cat $filename2 $filename1 | grep "$datime" >> $localdir$tfile/$logname".log_`hostname`_`date +%Y%m%d%H%M%S`"
# write (cat) latest two webui.log files and grep every 10 mins messages into webui.log_hostname_date file

else touch $localdir/tmp_file/$logname".log_`hostname`_`date +%Y%m%d%H%M%S`"
#create one webui.log_hostname_date file if no message in this 10 mins ,
#this file only for record script work ok but not webui.log generate.
fi

#files=`ls /opt/tmp/refer/* 2> /dev/null | wc -l `
files=`ls $localdir$tfile/* 2> /dev/null | wc -l `

writeLog

if [ $files -eq 0 ] ; then
echo "No file need upload_"`hostname`_`date +%Y%m%d%H%M%S` >> $logPath
echo "####################################" >> $logPath
exit 0
fi

startFtp

#ALL dump file send to /opt/tmp/dump from this version
#dump every uploaded file for keep local and monitor on /tmp/dump/webui/
cp -a $localdir$tfile/* /opt/tmp/dump/$logname

rm -f $localdir/tmp_file/*
#remove the webui.log_hostname_date file we create

