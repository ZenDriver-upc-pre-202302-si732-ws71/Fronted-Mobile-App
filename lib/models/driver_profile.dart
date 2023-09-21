import 'package:zendriver/models/license.dart';

import 'driver.dart';

class DriverProfile{
    int id;
    Driver driver;
    License license;


    DriverProfile({required this.id, required this.driver, required this.license});


    DriverProfile.fromJson(Map<String, dynamic> json) 
      : id = json['id'],
        driver = Driver.fromJson(json['driver']),
        license = License.fromJson(json['license']);

}