import 'package:zendriver/models/user.dart';

class Driver{
  int? id;
  User? user;
  String? experienceYears;

  Driver({required this.id, required this.user, required this.experienceYears});
  

  Driver.fromJson(Map<String, dynamic> json) 
    : id = json['id'],
      user = User.fromJson(json['user']),
      experienceYears = json['startingYear'];



}