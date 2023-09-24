import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zendriver/models/profiles.dart';
import 'package:zendriver/models/user_sign_up.dart';
import 'package:zendriver/services/profile_service.dart';
import '../../models/user_profile.dart';
import '../../models/user_update.dart';
import '../../services/user_profile_service.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserProfile? user;
  UserProfileService? profileService;
  Future<SharedPreferences>? _prefs;
  String? tuken;
  String? id;
  String? userRole = '';
  int? userId;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController birthdayDateController = TextEditingController();

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
    user = await profileService?.getData(userId!);
    setState(() {
      user = user;
      userRole = user?.role ?? '';
      firstNameController.text = user?.firstname ?? '';
      lastNameController.text = user?.lastname ?? '';
      usernameController.text = user?.username ?? '';
      passwordController.text = 'Contact Admin to change';
      phoneController.text = user?.phone ?? '';
      roleController.text = user?.role ?? '';
      descriptionController.text = 'You are a user of ZenDriver';
      imageUrlController.text = 'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg';
      birthdayDateController.text = '12-9-1995';
    });
  }

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    profileService = UserProfileService();
    initialize();
    _getToken();
    super.initState();
  }

  void _getToken() async {
    final pref = await _prefs;
    tuken = pref?.getString('token');
    id = pref?.getString('id');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void signOut() async {
    final pref = await _prefs;
    pref?.clear();
    navigateToLogin();
  }

  void navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SigninScreen()),
    );
  }

  void updateUserProfile() async {

    final updatedUser = UserUpdate(
      firstname: firstNameController.text,
      lastname: lastNameController.text,
      username: usernameController.text,
      phone: phoneController.text,
    );

    try {

      final responseUpdate = await profileService?.updateData(userId!, updatedUser);

      print(userId!);
      print('----------------User response update----------------');
      print(responseUpdate);
      final response = await profileService?.getData(userId!);
      print('----------------User actual----------------');
      print(response);
      setState(() {
        user = response;
        print(user);

      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final String? image = user?.imageUrl;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 55.0),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg'),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Text(
                  '${user?.firstname} ${user?.lastname}',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              /* Center(
                child: Text(
                  '${user?.description}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ), */
              const SizedBox(height: 16.0),
              buildTextField('Firstname', firstNameController),
              buildTextField('Lastname', lastNameController),
              buildTextField('Username', usernameController),
              buildTextLabelField('Password', 'Contact Admin to change'),
              //buildTextField('Description', descriptionController),
              buildTextField('Phone', phoneController),
              buildTextLabelField('Role', userRole!),
              //buildTextField('BrithdayDate', birthdayDateController),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: signOut,
                    child: const Text('Sign Out'),
                  ),
                  ElevatedButton(
                    onPressed: updateUserProfile,
                    child: const Text('Update'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@override
Widget buildTextField(String labelText, TextEditingController controller) {
  return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Text(
            labelText,
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 200,
                child: TextField(
                  controller: controller,
                ),
              ),
            ),
          ),
        ],
      ));
}


@override
Widget buildTextLabelField(String labelText, String labelText2) {
  return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Text(
            labelText,
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 200,
                child: Text(
                  labelText2,
                ),
              ),
            ),
          ),
        ],
      ));
}
