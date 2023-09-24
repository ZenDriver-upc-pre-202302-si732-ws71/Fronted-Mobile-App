import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zendriver/ui/shared/services/base_service.dart';


import '../models/user_sign_up.dart';
import 'login_service.dart';

class UserSignUpService extends BaseService {
  late final String baseUrl;
  //final String baseUrl = 'http://192.168.1.16/api/v1/users/';
  
  UserSignUpService() {
    baseUrl = produceUri("users");
  }

  Future<SignupResponse> signUp(UserSignUp user) async {
    final url = '$baseUrl/sign-up';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    if (response.statusCode == HttpStatus.ok) {
      return SignupResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == HttpStatus.badRequest) {
      throw Exception('username already exists');
    } else {
      throw Exception('Failed to sign up');
    }
  }

 /*  Future<User> getUserById(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = '$baseUrl/$id';
    final response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader: prefs.getString('token') ?? ''
    });

    if (response.statusCode == HttpStatus.ok) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  } */
}

