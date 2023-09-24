class UserUpdate {
  String? firstname;
  String? lastname;
  String? username;
  String? phone;

  UserUpdate({this.firstname, this.lastname, this.username, this.phone});

  UserUpdate.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['username'] = this.username;
    data['phone'] = this.phone;
    return data;
  }
}