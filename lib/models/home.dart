class User {
  final int id;
  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final String phone;
  final String role;
  final String description;
  final String imageUrl;
  final String birthdayDate;

  User({
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
}

class Post {
  int id;
  String descriptionSocialNetwork;
  String urlImageSocialNetwork;
  int like; 
  User user;

  Post({
    required this.id,
    required this.descriptionSocialNetwork,
    required this.urlImageSocialNetwork,
    required this.like,
    required this.user,
  });
}

Post mapToPost(dynamic json) {
  final userJson = json['user'];
  final user = User(
    id: userJson['id'],
    firstName: userJson['firstName'],
    lastName: userJson['lastName'],
    userName: userJson['userName'],
    password: userJson['password'],
    phone: userJson['phone'],
    role: userJson['role'],
    description: userJson['description'],
    imageUrl: userJson['imageUrl'],
    birthdayDate: userJson['birthdayDate'],
  );

  return Post(
    id: json['id'],
    descriptionSocialNetwork: json['descriptionSocialNetwork'],
    urlImageSocialNetwork: json['urlImageSocialNetwork'],
    like: json['like'],
    user: user,
  );
}
