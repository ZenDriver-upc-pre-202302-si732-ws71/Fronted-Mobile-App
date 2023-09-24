class UserUpdate {
  String? firstName;
  String? lastName;
  String? username;
  String? phone;
  Recruiter? recruiter;
  Driver? driver;

  UserUpdate(
      {this.firstName,
      this.lastName,
      this.username,
      this.phone,
      this.recruiter,
      this.driver});

  UserUpdate.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    phone = json['phone'];
    recruiter = json['recruiter'] != null
        ? new Recruiter.fromJson(json['recruiter'])
        : null;
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['phone'] = this.phone;
    if (this.recruiter != null) {
      data['recruiter'] = this.recruiter!.toJson();
    }
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    return data;
  }
}

class Recruiter {
  String? email;
  String? description;

  Recruiter({this.email, this.description});

  Recruiter.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['description'] = this.description;
    return data;
  }
}

class Driver {
  String? address;
  String? birth;

  Driver({this.address, this.birth});

  Driver.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    birth = json['birth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['birth'] = this.birth;
    return data;
  }
}