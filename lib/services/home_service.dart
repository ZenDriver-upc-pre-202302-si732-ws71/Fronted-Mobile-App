import 'dart:convert';

import 'package:http/http.dart' as http;

class HomeService {
  final String homebaseUrl =
      'https://zendriver.azurewebsites.net/api/v1/socialnetwork';

  Future<List<dynamic>> getPosts() async {
    final response = await http.get(Uri.parse(homebaseUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> updatePostLike(int postId, int likeCount) async {
    final url = '$homebaseUrl/$postId/like';

    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to update post like');
    }
  }
}
