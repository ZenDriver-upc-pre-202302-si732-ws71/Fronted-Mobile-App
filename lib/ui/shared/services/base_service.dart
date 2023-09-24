import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BaseService {
  //final String baseUri = "https://zendrivers.azurewebsites.net";
  final String baseUri = "https://localhost:7078";
  final String apiVersion = "api/v1";

  Future<http.Response> get(String url) async {
    final prefs = await SharedPreferences.getInstance();
    return await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.get("token")}'
    });
  }

  Future<http.Response> post(String url, Object? body) async {
    final prefs = await SharedPreferences.getInstance();
    return await http.post(Uri.parse(url),
       headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.get("token")}'
      },
      body: body
    );
  }

  List<Ty> responseMap<Ty>(String body, Ty Function(Map<String, dynamic>) converter) =>
      (jsonDecode(body) as Iterable).map((item) => converter(item)).toList();

  String produceUri(String endUri) => "$baseUri/$apiVersion/$endUri";

  Future<List<Ty>> getAllFrom<Ty>(String url, Ty Function(Map<String, dynamic>) converter) async {
    var result = await get(url);
    return result.statusCode == HttpStatus.ok ? responseMap(result.body, converter) : List.empty();
  }
}