import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:zendriver/models/driver_profile.dart';

class DriverProfileService {
  final String driverProfilebaseUrl =
      'https://zendriver.azurewebsites.net/api/v1/driverprofile';

  Future<List<DriverProfile>> getProfiles(licenseType) async {
    final response = await http.get(Uri.parse(driverProfilebaseUrl));
    if (response.statusCode == HttpStatus.ok) {
      final profiles = json.decode(response.body).cast<Map<String, dynamic>>();
      final filteredProfiles = profiles
          .where((profile) => profile['license']['category'] == licenseType)
          .toList();
      return filteredProfiles
          .map<DriverProfile>((json) => DriverProfile.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load profiles');
    }
  }

  Future<List<DriverProfile>> getAllProfiles() async {
    final response = await http.get(Uri.parse(driverProfilebaseUrl));
    if (response.statusCode == HttpStatus.ok) {
      final profiles = json.decode(response.body).cast<Map<String, dynamic>>();
      return profiles
          .map<DriverProfile>((json) => DriverProfile.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load profiles');
    }
  }
}
