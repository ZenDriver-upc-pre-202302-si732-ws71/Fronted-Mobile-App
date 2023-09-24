import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zendriver/services/home_service.dart';
import 'package:zendriver/entities/post.dart';


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
  


  Future<void> _fetchPosts() async {
    try {
      final data = await _homeService.getPosts();
      setState(() {
        _posts = data.map((post) => Post.fromJson(post)).toList();
        _likedStatus = List<bool>.filled(_posts.length, false);
      });
    } catch (e) {
      
      // Handle error
    }
  }



void _toggleLike(int index) {
  setState(() {
    _likedStatus[index] = !_likedStatus[index];
    /*
    * if (_likedStatus[index]) {
      _posts[index].like++;
    } else {
      _posts[index].like--;
    }
    * */
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
                    leading: const Icon(Icons.person),
                    title: Text(
                      '${post.recruiter?.account?.firstname} ${post.recruiter?.account?.lastname}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Image.network(post.image!),
                  const SizedBox(height: 8),
                  Text(post.description!),
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
                    //title: Text('${post.like} Likes'),
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
