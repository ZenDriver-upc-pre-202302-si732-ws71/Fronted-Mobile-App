import 'package:flutter/material.dart';
import 'package:zendriver/models/home.dart';
import 'package:zendriver/services/home_service.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeService _homeService = HomeService();
  List<Post> _posts = [];
  List<bool> _likedStatus = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }
  
  Post _mapToPost(dynamic json) {
    return mapToPost(json);
  }


  Future<void> _fetchPosts() async {
    try {
      final data = await _homeService.getPosts();
      setState(() {
        _posts = data.map((post) => _mapToPost(post)).toList();
        _likedStatus = List<bool>.filled(_posts.length, false);
      });
    } catch (e) {
      
      // Handle error
    }
  }



void _toggleLike(int index) {
  setState(() {
    _likedStatus[index] = !_likedStatus[index];
    if (_likedStatus[index]) {
      _posts[index].like++;
    } else {
      _posts[index].like--;
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publicaciones'),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (BuildContext context, int index) {
          final post = _posts[index];

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(post.user.imageUrl),
                      radius: 20,
                    ),
                    title: Text(
                      '${post.user.firstName} ${post.user.lastName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Image.network(post.urlImageSocialNetwork),
                  const SizedBox(height: 8),
                  Text(post.descriptionSocialNetwork),
                  const Divider(), // Línea horizontal
                  ListTile(
                    leading: IconButton(
                      icon: Icon(
                        _likedStatus[index]
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: _likedStatus[index] ? Colors.red : null,
                      ),
                      onPressed: () => _toggleLike(index),
                    ),
                    title: Text('${post.like} Likes'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
