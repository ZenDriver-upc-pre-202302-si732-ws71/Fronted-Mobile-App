import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zendriver/ui/shared/services/base_service.dart';
import '../models/profiles.dart';
import '../models/user_profile.dart';

class UserProfileService extends BaseService {
  late final String baseUrl;

  UserProfileService() {
    baseUrl = produceUri("users");
  }
  
  Future<UserProfile?> getData(int userId) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$baseUrl/$userId'), headers: {
      HttpHeaders.authorizationHeader: prefs.getString('token') ?? ''
    });
    if (response.statusCode == HttpStatus.ok) {
      return UserProfile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }
  
  Future<void> updateData(UserProfile updatedProfile) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final response = await http.put(
    Uri.parse('$baseUrl/${updatedProfile.id}'),
    headers: {
      HttpHeaders.authorizationHeader: prefs.getString('token') ?? '',
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    body: jsonEncode(updatedProfile.toJson()),
  );

  if (response.statusCode == HttpStatus.ok) {
    // Actualización exitosa
    // Puedes mostrar una notificación o realizar cualquier otra acción deseada
  } else {
    // Error al actualizar el perfil
    throw Exception('Failed to update profile');
  }
}

}


