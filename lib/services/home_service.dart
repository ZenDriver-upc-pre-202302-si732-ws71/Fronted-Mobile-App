import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zendriver/ui/shared/services/base_service.dart';

class HomeService extends BaseService {
  late final String homebaseUrl;

  HomeService() {
    homebaseUrl = produceUri("socialnetwork");
  }

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
