import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zendriver/ui/pages/filtered_drivers.dart';

import '../../models/profiles.dart';
import '../../services/profile_service.dart';

class SearchYourDriver extends StatefulWidget {
  const SearchYourDriver({super.key});

  @override
  State<SearchYourDriver> createState() => _SearchYourDriverState();
}

class _SearchYourDriverState extends State<SearchYourDriver> {
  final _licenseList = ["AI", "AIIA", "AIIB", "AIIIB", "AIIIA", "AIIIC"];
  userProfile? profile;
  String? selectedlicense = "AI";
  Future<SharedPreferences>? _prefs;
  userProfile? user;
  ProfileService? profileService;
  int? userId;
  Color _color = const Color.fromRGBO(5, 53, 87, 1);
  initialize()async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
    user = await profileService?.getData(userId!);
    setState(() {
      user = user;
    });
  }


  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    profileService = ProfileService();
    initialize();
    super.initState();

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 65,
          ),
          Column(
            children: [
              const Image(
                  image: AssetImage('assets/logo.png'), width: 50, height: 50),
              const Text(
                'ZenDriver',
                style: TextStyle(fontSize: 10),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(user?.role == "Recruiter" ?"¿Cúal es su chofer ideal?" : "Conoce a otros choferes!",
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ],
          ),
         
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 150,
            child: DropdownButtonFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: 'Tipo de licencia'),
                icon: const Icon(Icons.arrow_drop_down),
                value: selectedlicense,
                items: _licenseList
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedlicense = val as String;
                  });
                }),
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      backgroundColor: _color,
                      textStyle: const TextStyle(
                        fontSize: 14,
                      )
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FilteredDrivers(
                                  licenseType: selectedlicense!,
                                  operation: 0,
                                  title:
                                      "Conductores con licencia $selectedlicense")));
                    },
                    child: const Text(
                      'Filtrar ya',
                      style: TextStyle(fontSize: 18),
                    )
                    ),
              ),
                  
            ],
          ),
          Padding(
             padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
             child: ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 60),
                      backgroundColor: _color,
                      textStyle: const TextStyle(
                        fontSize: 14,
                      )
                    ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FilteredDrivers(
                              licenseType: selectedlicense!,
                              operation: 1,
                              title: "Conductores")));
                },
                child: const Text("Mostrar Todos los conductores")),
           ),
        ],
      ),
    ));
  }
}
