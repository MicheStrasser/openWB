#!/bin/bash

MODULE_PATH="/var/www/html/openWB/modules/soc_leafnew1"

source /home/pi/.profile

if [ ! -f "$MODULE_PATH/dartnissanconnect/getBattery.dart" ]; then
    cp $MODULE_PATH/getBattery.dart $MODULE_PATH/dartnissanconnect/getBattery.dart
fi

soctimer=$(</var/www/html/openWB/ramdisk/soctimer)
if (( soctimer < 6 )); then
	soctimer=$((soctimer+1))
	echo $soctimer > /var/www/html/openWB/ramdisk/soctimer
else
    dart $MODULE_PATH/dartnissanconnect/getBattery.dart $leafnewuser $leafnewpassword &
    echo 0 > /var/www/html/openWB/ramdisk/soctimer
fi