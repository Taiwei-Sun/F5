#!/bin/sh
###2018 1217 v4. for upload tdr > one, modify tdrmputlist
## add dump to /tmp/ftp_dump/
sleep 90

host1="172.17.34.18"
host3="172.16.22.147"

logname="tdr"

id1="pdpftp"
pw1="DEA2tvm"
remodir1="dea_data"


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

tdrs_files(){
cd $localdir
#ls -t tdr_export_*.csv.gz > /tmp/tdrmputlist.log
find /opt/traffix/reports/tdr -maxdepth 1 -mmin -30 -type f  -exec basename {} \; > /tmp/tdrmputlist.log
cat /tmp/tdrmputlist.log | while read line
do
#cp -a $localdir/$filename $localdir/tmp_file/$filename".upload"
cp -a $localdir/$line $localdir/tmp_file/$line".upload"
echo $localdir/tmp_file/$line".upload" >> /tmp/uploaded_log.txt
done
}

ftp_upload(){

cp -a $localdir/$filename $localdir/tmp_file/$filename".upload"
cp -a $localdir/tmp_file/* /tmp/ftp_dump/

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

}

mftp_upload(){
echo "######## mput tdrs to FTP #######" >> /tmp/uploaded_log.txt
tdrs_files
#cp -a $localdir/$filename $localdir/tmp_file/$filename".upload"
cp -a $localdir/tmp_file/* /tmp/ftp_dump/



echo "open $host1
user $id1 $pw1
lcd $localdir$tfile
binary
cd $remodir1
mput *
bye
" | ftp -vin
cd $localdir$tfile
echo `hostname`_`date +%Y%m%d%H%M%S`"--"$host1 >> /tmp/uploaded_log.txt
#echo $localdir/tmp_file/$filename".upload" >> /tmp/uploaded_log.txt



echo "open $host3
user $id3 $pw3
lcd $localdir$tfile
binary
cd $remodir3
mput *
bye
" | ftp -vin
cd $localdir$tfile
echo `hostname`_`date +%Y%m%d%H%M%S`"--"$host3 >> /tmp/uploaded_log.txt
#echo $localdir/tmp_file/$filename".upload" >> /tmp/uploaded_log.txt


mv -f $localdir$tfile/* $localdir/tmp_tarfile/.

}

cd $localdir
#cp -u tdr_export_*.csv.gz /tmp/ftp_dump/
TDR_N=`find /opt/traffix/reports/tdr -maxdepth 1 -mmin -30 -type f  -exec basename {} \; | wc -l `
TDR_NS=`find /opt/traffix/reports/tdr -maxdepth 1 -mmin -30 -type f  -exec basename {} \; `
echo `hostname`_`date +%Y%m%d%H%M%S`_TS >> /tmp/uploaded_log.txt
ls -l /opt/traffix/reports/tdr  >> /tmp/uploaded_log.txt
if [ "`find /opt/traffix/reports/tdr -maxdepth 1 -mmin -30 -type f  -exec basename {} \; | wc -l `" -gt 1 ] ; then
echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
echo "TDR files found more than one,UnNormal!!" $TDR_N   >> /tmp/uploaded_log.txt
echo $TDR_NS  >> /tmp/uploaded_log.txt
echo "######################" >> /tmp/uploaded_log.txt

mftp_upload
exit 0
fi

filename="`find /opt/traffix/reports/tdr -maxdepth 1 -mmin -30 -type f  -exec basename {} \; `"
#if [ ! -s /tmp/autocsvlist.log ] ; then
if [ ! -e "$filename" ] ; then
echo `hostname`_`date +%Y%m%d%H%M%S` >> /tmp/uploaded_log.txt
echo No such TDR file found !!  >> /tmp/uploaded_log.txt
#ls -l /opt/traffix/reports/tdr  >> /tmp/uploaded_log.txt
echo "######################" >> /tmp/uploaded_log.txt

exit 0
fi

ftp_upload