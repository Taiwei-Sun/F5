#!/bin/sh
#current version: tdr_tarftp_20140901-1, last version: tdr_tarftp_20140827-1
sleep 30

host="172.27.21.120"
logname="tdr"
id="ftpdea"
pw="user_0909"
remodir="/LTE_Core/DEA/TDR/daily"
localdir="/opt/traffix/reports/tdr"
tfile="/tmp_file"

if [ ! -d "$localdir$tfile" ]; then
mkdir "$localdir$tfile"
fi

if [ ! -d "$localdir/tmp_tarfile" ]; then
mkdir "$localdir/tmp_tarfile"
fi

if [ ! -d "$localdir/tmp_tarfile2" ]; then
mkdir "$localdir/tmp_tarfile2"
fi

if [ ! -d "$localdir/tmp_tarftpfile" ]; then
mkdir "$localdir/tmp_tarftpfile"
fi

cd $localdir/tmp_tarfile
filename="`find . -mmin -1560 -mmin +120 ! -type d -exec basename {} \; `"
echo $filename > "/tmp/$logname""_tar_ftplist.log"

if [ -z `cat /tmp/$logname""_tar_ftplist.log` ] ; then

echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
echo No tar  TDR file found !!  >> /tmp/uploaded_log.txt
ls -l $localdir/tmp_tarfile >> /tmp/uploaded_log.txt
echo "######################" >> /tmp/uploaded_log.txt
exit 0
fi

cat "/tmp/$logname""_tar_ftplist.log" | while read line
do

mv -f $localdir/tmp_tarfile/$line $localdir/tmp_tarfile2/.
#move $filename".upload file from /tmp_tarfile to  /tmp_tarfile2

done
cd $localdir/tmp_tarfile2/
tar -cf  $localdir/tmp_tarftpfile/TDR_tar_export_`date -d '1 day ago' +%m"-"%d"-"%Y`.tar .
#make .tar file from /tmp_tarfile2/ and save on /tmp_tarftpfile 

echo "open $host
user $id $pw
lcd $localdir/tmp_tarftpfile
binary
cd $remodir
mput *
bye
" | > /tmp/one_day_ftp.log ftp -vin
cd $localdir/tmp_tarftpfile/
echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
ls -l >> /tmp/uploaded_log.txt
echo " the tar file include as : " >> /tmp/uploaded_log.txt
cat /tmp/$logname""_tar_ftplist.log >> /tmp/uploaded_log.txt
echo " (the end) "  >> /tmp/uploaded_log.txt

cat /tmp/one_day_ftp.log >> /opt/traffix/sdc/logs/webui/codeftp_tdrtar.log

#if [ ! -d "/tmp/dump" ]; then
#mkdir "/tmp/dump"
#fi

#cp  $localdir/tmp_tarfile2/* /tmp/dump
#cp  $localdir/tmp_tarftpfile/* /tmp/dump
#dump every uploaded file for keep local and monitor on /tmp/dump

rm -f $localdir/tmp_tarfile2/*
#/tmp_tarfile2 now is .upload files with 15mins saved TDR 

#// check echo new ftp result to one_day_ftp.log
RemoteFile=`cat /tmp/one_day_ftp.log |grep "226 Transfer OK" | wc -l`
#RemoteFile=`cat /tmp/one_day_ftp.log |grep "226 File receive OK." | wc -l`
#DEA use 226 Transfer OK
#DRA use 226 File receive OK.

LocalFile=`ls $localdir/tmp_tarftpfile | wc -l `

if [ "$RemoteFile" != "" ] && [ $RemoteFile -eq $LocalFile  ]; then
echo -ne "\n*****\n`hostname`_`date +%Y%m%d%H%M%S`\ntdr_tarftp.sh\nFollowing files FTP upload OK\n`ls -al $localdir/tmp_tarftpfile/`\n*****\n" >>  /tmp/uploaded_log.txt
rm -f $localdir/tmp_tarftpfile/*
#/tmp_tarftpfile now is tar file yesterday as one tar file
else
echo -ne "\n*****\n`hostname`_`date +%Y%m%d%H%M%S`\ntdr_tarftp.sh\nFollowing files FTP upload failed\n`ls -al $localdir/tmp_tarftpfile/`\n*****\n" >> /var/log/messages
echo -ne "\n*****\n`hostname`_`date +%Y%m%d%H%M%S`\ntdr_tarftp.sh\nFollowing files FTP upload failed\n`ls -al $localdir/tmp_tarftpfile/`\n*****\n" >>  /tmp/uploaded_log.txt
fi

#becaue use find command, /tmp_tarfile dont need to clean.