#!/bin/sh
#current version: housekp_20150407-1, last version: housekp_20150212-1
#remove /opt/tmp/dump/ file over 30 days
#remove /opt/tmp/dump/backup restore file over 10 days
localdir="/opt/tmp"

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
#kpi is possibility more than 30 files
writeLog(){
echo "##### this log start #################" >> $logPath
echo `hostname`_`date +%Y-%m%d-%H%M%S` >> $logPath
echo "Here the script :"$script_name   >> $logPath
echo $localdir  >> $logPath
find /opt/tmp/ -mtime +30 -exec ls -l {} \; >> $logPath


#echo $files " files on this upload" >> $logPath
}


script_name="housekp"
#tfile="/tmp_file"

#f1="$localdir$tfile"
#f2="$localdir/tmp_tarfile"
#f3="$localdir/tmp_tarfile2"
#f4="/opt/tmp/dump/$logname"
f5="/opt/tmp/log/$script_name"
#f6="/opt/tmp/refer"
#f7="/opt/tmp/dump/$logname/$TS"
f8="/opt/tmp/code_ftp"
arr=(
#$f1 $f2 $f3 $f4 $f5 $f6 $f7
$f5 $f8
)

for ((a=0; a<${#arr[@]}; a++));do
tempdir="${arr[a]}"
checkDir
done

logPath=$f5/$script_name_`date +%Y-%m%d`_`hostname`.txt

writeLog

#2015 02 12 add cat crontab to /opt/tmp/dump for backup restore file list
find /opt/tmp/dump/ -mtime +30 -exec \rm -r {} \;  > /dev/null 2>&1
find /opt/tmp/log/ -mtime +30 -exec \rm -r {} \;  > /dev/null 2>&1

echo  `date +%Y%m%d%H%M`_`hostname` > /opt/tmp/dump/cat_cron_`hostname`.log
crontab -l >> /opt/tmp/dump/cat_cron_`hostname`.log

#this for keep latest script on root folder
if [ ! -d "/opt/tmp/dump/root_folder" ]; then
mkdir -p "/opt/tmp/dump/root_folder"
fi

cp -a /root/* /opt/tmp/dump/root_folder
