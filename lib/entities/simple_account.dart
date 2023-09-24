class SimpleAccount {
  int? id;
  String? firstname;
  String? lastname;
  String? username;
  String? phone;

  SimpleAccount({this.id, this.firstname, this.lastname, this.username, this.phone});

  SimpleAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['username'] = this.username;
    data['phone'] = this.phone;
    return data;
  }
}