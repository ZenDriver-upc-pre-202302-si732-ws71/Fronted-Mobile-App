class userProfile {
   int id;
   String firstName;
   String lastName;
   String userName;
   String password;
   String phone;
   String role;
   String description;
   String imageUrl;
   String birthdayDate;

  userProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.password,
    required this.phone,
    required this.role,
    required this.description,
    required this.imageUrl,
    required this.birthdayDate,
  });

  userProfile.fromJson(Map<String, dynamic> json):
      id = json['id'],
      firstName = json['firstName'],
      lastName= json['lastName'],
      userName= json['username'],
      password= json['password'],
      phone= json['phone'],
      role= json['role'],
      description= json['description'],
      imageUrl=json['imageUrl'],
      birthdayDate= json['birthdayDate'];

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'password': password,
      'phone': phone,
      'role': role,
      'description': description,
      'imageUrl': imageUrl,
      'birthdayDate': birthdayDate,
    };
  }
}

