import 'dart:convert';
import 'dart:io';

import 'package:zendriver/entities/driver.dart';
import 'package:zendriver/entities/find_driver.dart';
import 'package:zendriver/ui/shared/services/base_service.dart';

class DriverService extends BaseService {
  late final String _driversUrl;
  DriverService() {
    _driversUrl = produceUri("drivers");
  }

  Future<List<Driver>> getAll() => getAllFrom(_driversUrl, Driver.fromJson);
  Future<List<Driver>> getByLicenseType(FindDriver findDriver) async {
    final response = await post("$_driversUrl/find", jsonEncode(findDriver.toJson()));
    return response.statusCode == HttpStatus.ok ? responseMap(response.body, Driver.fromJson) : List.empty();
  }
}