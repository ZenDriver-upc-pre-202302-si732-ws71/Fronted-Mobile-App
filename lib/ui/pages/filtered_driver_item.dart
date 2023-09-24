import 'package:flutter/material.dart';
import 'package:zendriver/entities/driver.dart';
import 'package:zendriver/ui/pages/driver_profile.dart';


class DriverItem extends StatefulWidget {
  const DriverItem({super.key, required this.driver});
  final Driver driver;

  @override
  State<DriverItem> createState() => _DriverItemState();
}

class _DriverItemState extends State<DriverItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Container(
        color : const Color.fromRGBO(226,234,238,1),
        padding: const EdgeInsets.all(16.0),
        
        child: 
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              
              
              height: 200,
              width: 200,
              child: const Image(
                  //image: NetworkImage('https://www.drakonball.com/wp-content/uploads/2023/02/los-mejores-memes-de-dragon-ball.jpg'),
                  image: NetworkImage("https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg"),
                  width: 50,
                  height: 50),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Container(
                    width: 200,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("${widget.driver.account?.firstname} ${widget.driver.account?.lastname}")),
                  
                  const SizedBox(height: 16),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 50),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                        
                        MaterialPageRoute(builder: (context) =>  DriverProfileScreen(driver: widget.driver)));
                      },
                      child: const Text(
                        'Ver Perfil',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ))                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
