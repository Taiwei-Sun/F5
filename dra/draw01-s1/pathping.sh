#!/bin/bash
#2018-10-29 like windows pathping, version 1


#check arguments only one
if [ "$#" -ne 1 ]; then
 echo "please type 'pathping.sh <ip>'";
 exit 1;
fi

#ping ip(argument)
ping -c1 $1 > /dev/null;
if [ "$?" -ne 0 ]; then
 echo "ping failed";
 exit 1;
 
else 
 echo "ping OK"
fi

#traceroute ip(argument) and collect nodes ip from traceroute
mkdir -p /tmp/pingTmp`date +%Y%m%d`;
cd /tmp/pingTmp`date +%Y%m%d`;
traceroute -I $1 &> trace.log;
#cat trace.log;
cat trace.log|grep -v 'traceroute to'|sed 's/[()]/!/g'|cut -f2 -d '!' > nodeList.log;
#cat nodeList.log;
nodes=(`cat nodeList.log|grep -v '*'`);

#ping nodes ip to log files
for((i=0;i<${#nodes[@]};i++))
do
 echo "ping "${nodes[$i]};
 ping ${nodes[$i]} &> pingT$i.log &
done

#sleep 5 min
echo "7200s";
sleep 7200;

#stop ping
for((i=1;i<${#nodes[@]}+1;i++))
do
 echo 'kill %'$i;
 kill -SIGINT %$i;
done


#tar log files

#rm -rf /tmp/pingTest`date +%Y%m%d`
