class UserProfile {
  int? id;
  String? firstname;
  String? lastname;
  String? username;
  String? phone;
  String? role;
  Recruiter? recruiter;
  Driver? driver;

  UserProfile(
      {this.id,
      this.firstname,
      this.lastname,
      this.username,
      this.phone,
      this.role,
      this.recruiter,
      this.driver});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    phone = json['phone'];
    role = json['role'];
    recruiter = json['recruiter'] != null
        ? new Recruiter.fromJson(json['recruiter'])
        : null;
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['role'] = this.role;
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
  int? companyId;

  Recruiter({this.email, this.description, this.companyId});

  Recruiter.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    description = json['description'];
    companyId = json['companyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['description'] = this.description;
    data['companyId'] = this.companyId;
    return data;
  }
}


class Driver {
  int? id;
  String? address;
  String? birth;

  Driver({this.id, this.address, this.birth});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    birth = json['birth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['birth'] = this.birth;
    return data;
  }
}