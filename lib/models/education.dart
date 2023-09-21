import 'package:zendriver/models/driver_profile.dart';

class Education{
  int id;
  String gradeEducation;
  DriverProfile driverProfile;

  
  Education({required this.id, required this.gradeEducation, required this.driverProfile});

  Education.fromJson(Map<String, dynamic> json) 
    : id = json['id'],
      gradeEducation = json['gradeEducation'],
      driverProfile = DriverProfile.fromJson(json['driverProfile']);
}