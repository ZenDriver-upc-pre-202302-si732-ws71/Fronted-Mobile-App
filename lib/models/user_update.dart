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
    return {
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'phone': phone,
    };
  }
}