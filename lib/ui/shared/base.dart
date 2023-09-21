import 'package:flutter/material.dart';
import 'package:zendriver/ui/shared/routes.dart';

import 'bottom_nav.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int index = 0;
  BottomNav ?bottomNav;

  @override
  void initState() {
    bottomNav = BottomNav(currentIndex: (i){
      setState(() {
        index = i;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Routes(
          index: index,
        ),
        bottomNavigationBar: bottomNav,
      ),
    );
  }
}