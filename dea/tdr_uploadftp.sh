#!/bin/sh

sleep 30

#host2="172.16.1.176"
host1="172.17.34.18"
host2="172.16.20.195"
host3="172.16.22.147"

logname="tdr"

id1="pdpftp"
pw1="DEA2tvm"
remodir1="dea_data"

#id2="cdrfp"
#pw2="cdr0935Ftp"
#remodir2="/FMS/AP01/cdrfp/TWM_S6A"

id2="cdrfp"
pw2="cdr0935Ftp"
remodir2="/FMS_ARC/cdrfp/TWM_S6A"

id3="cdrftp"
pw3="2016#Cdrexe"
remodir3="/CMD/CDR/TWM/F5SDC"

localdir="/opt/traffix/reports/tdr"
tfile="/tmp_file"



if [ ! -d "$localdir$tfile" ]; then
mkdir "$localdir$tfile"
fi

if [ ! -d "$localdir/tmp_tarfile" ]; then
mkdir "$localdir/tmp_tarfile"
fi


if [ ! -d "$localdir/tmp_tartfile2" ]; then
mkdir "$localdir/tmp_tarfile2"
fi

if [ ! -d "/tmp/ftp_dump" ]; then
mkdir "/tmp/ftp_dump"
fi


cd $localdir

if [ "`find /opt/traffix/reports/tdr -maxdepth 1 -mmin -30 -type f  -exec basename {} \; | wc -l `" -gt 1 ] ; then
echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
echo "TDR files found more than one,UnNormal!!"  >> /tmp/uploaded_log.txt
echo "######################" >> /tmp/uploaded_log.txt

exit 0
fi

filename="`find /opt/traffix/reports/tdr -maxdepth 1 -mmin -30 -type f  -exec basename {} \; `"
#if [ ! -s /tmp/autocsvlist.log ] ; then
if [ ! -e "$filename" ] ; then
echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
echo No such TDR file found !!  >> /tmp/uploaded_log.txt
echo "######################" >> /tmp/uploaded_log.txt

exit 0
fi

cp -a $localdir/$filename $localdir/tmp_file/$filename".upload"
cp -a $localdir/tmp_file/* /tmp/ftp_dump/

echo "open $host2
user $id2 $pw2
lcd $localdir$tfile
binary
cd $remodir2
put *
bye
" | ftp -vin
cd $localdir$tfile
echo `hostname`_`date +%Y%m%d%H%M%S`"--"$host2  >> /tmp/uploaded_log.txt
echo $localdir/tmp_file/$filename".upload" >> /tmp/uploaded_log.txt



echo "open $host1
user $id1 $pw1
lcd $localdir$tfile
binary
cd $remodir1
put *
bye
" | ftp -vin
cd $localdir$tfile
echo `hostname`_`date +%Y%m%d%H%M%S`"--"$host1 >> /tmp/uploaded_log.txt
echo $localdir/tmp_file/$filename".upload" >> /tmp/uploaded_log.txt



echo "open $host3
user $id3 $pw3
lcd $localdir$tfile
binary
cd $remodir3
put *
bye
" | ftp -vin
cd $localdir$tfile
echo `hostname`_`date +%Y%m%d%H%M%S`"--"$host3 >> /tmp/uploaded_log.txt
echo $localdir/tmp_file/$filename".upload" >> /tmp/uploaded_log.txt


mv -f $localdir$tfile/* $localdir/tmp_tarfile/.