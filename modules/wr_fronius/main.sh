#!/bin/bash

#Auslesen eine Fronius Symo WR über die integrierte API des WR. Rückgabewert ist die aktuelle Wattleistung
#IP des Fronius Wechselrichter
ip=10.20.0.126


pvwatttmp=$(curl --connect-timeout 15 -s $ip/solar_api/v1/GetInverterRealtimeData.cgi?Scope=System)
pvwatt=$(echo $pvwatttmp | jq '.Body.Data.PAC.Values' | sed 's/.*://' | tr -d '\n' | sed 's/^.\{2\}//' | sed 's/.$//' )

#wenn WR aus bzw. im standby (keine Antwort) ersetze leeren Wert durch eine 0
re='^[0-9]+$'
if ! [[ $pvwatt =~ $re ]] ; then
   pvwatt="0"
fi
echo $pvwatt
#zur weiteren verwendung im webinterface
echo $pvwatt > /var/www/html/openWB/ramdisk/pvwatt