import 'package:dartnissanconnect/dartnissanconnect.dart';
import 'package:intl/intl.dart';
import 'dart:io';

main(List<String> arguments) {
    final soc_file = "/var/www/html/openWB/ramdisk/soc";

    if (arguments.length != 2) {
        print("USAGE: dart getBattery.dart [username] [password]");
        return;
    }
  
    var _username = arguments[0];
    var _password = arguments[1];
    
    final file = new File(soc_file);
    final sink = file.openWrite();
    
    NissanConnectSession session = new NissanConnectSession(debug: false);

    session
           .login(username: _username, password: _password)
           .then((vehicle) {
        vehicle.requestBatteryStatus().then((batteryStatus) {
            var percentageAsString = batteryStatus.batteryPercentage;
            var percentageAsInt = int.parse(percentageAsString.split(".")[0]);
            sink.write(percentageAsInt);
            sink.close();
        });
    });
}
