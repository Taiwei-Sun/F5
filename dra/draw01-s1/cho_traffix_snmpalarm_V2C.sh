# PURPOSE       : THIS SCRIPT IS TO MONITOR CURRENT CPF snmpcounter nodeTotalParsedRequests  OID .1.3.6.1.4.1.27611.1.4.5.9.0
#                 SEND CUSTOMED SNMPTRAP ALARM WHEN BOTH SDC NODE TPS USAGE IS OVER DEFINED THRESHOLD AND LICENSETPS
# CREATED BY    : LIM SAY PING
# CREATED DATE  : 23 MAR 2015
# Version       : 5.1
# Changes       : Added new TPS variables on both snmp trap and logs.. 
#		  snmptrap v2c enabled
# CUSTOMED SNMPTRAP VARIABLES: enterpriseSpecific, SITEID, LICUSAGE, SEVERITY, CURRENT-TPS


#!/bin/bash
SOURCENODE=`cat /etc/hosts | grep CPF | awk '{print $2}'`

#GLOBAL VARIABLES
SITEID=DRA-CHO
NMSSERVER=172.18.30.146
LICENSETPS=5000

MINORTHRESHOLD=50
MAJORTHRESHOLD=70
CRITICALTHRESHOLD=90

T1=0
T2=0
NODECOUNT=2
LICUSAGE=0

for H in $SOURCENODE
do
        V1=`snmpget -v1 -c TWMHPnms $H .1.3.6.1.4.1.27611.1.4.5.9.0  | awk '{print $4}'`

        if [ -z "$V1" ]; then
        V1=0
        NODECOUNT=$((NODECOUNT-1))
        fi
        T1=$((T1+V1))

done

#WAIT FOR 1 MINUTE then CALCULATE BOTH CURRENT VALUE
sleep 60
for H in $SOURCENODE
do
        V1=`snmpget -v1 -c TWMHPnms $H .1.3.6.1.4.1.27611.1.4.5.9.0  | awk '{print $4}'`

        if [ -z "$V1" ]; then
        V1=0
        fi
        T2=$((T2+V1))

done

TPS=$(((T2-T1) / (60*NODECOUNT)))
LICUSAGE=$(((TPS*100) / LICENSETPS))

# sending of TRAP if over license limit
if [ "$LICUSAGE" -gt "$CRITICALTHRESHOLD" ]; then
`snmptrap  -v  2c  -c  TWMHPnms $NMSSERVER ''  .1.3.6.1.4.1.27611.1.4.6  .1.3.6.1.4.1.27611.1.4.6.1 s $SITEID .1.3.6.1.4.1.27611.1.4.6.2 i $LICUSAGE .1.3.6.1.4.1.27611.1.4.6.3 s "CRITICAL" .1.3.6.1.4.1.27611.1.4.6.4 i $TPS`
        logger -i "SDC SITE - $SITEID , LICENSED TPS - $LICENSETPS, CURRENT TPS - $TPS, PERCENT OF LICENSE USAGE - $LICUSAGE, SEVERITY - CRITCAL"
else
if [ "$LICUSAGE" -gt "$MAJORTHRESHOLD" ]; then
`snmptrap  -v  2c  -c  TWMHPnms $NMSSERVER ''  .1.3.6.1.4.1.27611.1.4.6  .1.3.6.1.4.1.27611.1.4.6.1 s $SITEID .1.3.6.1.4.1.27611.1.4.6.2 i $LICUSAGE .1.3.6.1.4.1.27611.1.4.6.3 s "MAJOR" .1.3.6.1.4.1.27611.1.4.6.4 i $TPS`
        logger -i "SDC SITE - $SITEID , LICENSED TPS - $LICENSETPS, CURRENT TPS - $TPS, PERCENT OF LICENSE USAGE - $LICUSAGE, SEVERITY - MAJOR"
else
        if [ "$LICUSAGE" -gt "$MINORTHRESHOLD" ]; then
`snmptrap  -v  2c  -c  TWMHPnms $NMSSERVER ''  .1.3.6.1.4.1.27611.1.4.6  .1.3.6.1.4.1.27611.1.4.6.1 s $SITEID .1.3.6.1.4.1.27611.1.4.6.2 i $LICUSAGE .1.3.6.1.4.1.27611.1.4.6.3 s "MINOR" .1.3.6.1.4.1.27611.1.4.6.4 i $TPS`
        logger -i "SDC SITE - $SITEID , LICENSED TPS - $LICENSETPS, CURRENT TPS - $TPS, PERCENT OF LICENSE USAGE - $LICUSAGE, SEVERITY - MINOR"
        fi
fi
fi

