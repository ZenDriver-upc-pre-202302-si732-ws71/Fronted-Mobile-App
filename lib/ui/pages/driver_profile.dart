import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zendriver/entities/driver.dart';
import 'messages.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key, required this.driver});
  final Driver driver;
  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  num experienceYears = 0;
  int userId = 0;
  void initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId')!;
    final currentYear = DateTime.now().year;
    final experienceYear =
        num.tryParse('0');
    setState(() {
      experienceYears = currentYear - experienceYear!;
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                Text(
                    "Perfil de ${widget.driver.account!.firstname} ${widget.driver.account!.lastname}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                const Image(
                  image: AssetImage('assets/logo.png'),
                  width: 50,
                  height: 50,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 10,
              color: const Color.fromRGBO(2, 170, 238, 1),
              shadowColor: Colors.black,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: const Image(
                          image: NetworkImage("https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg"),
                          width: 150,
                          height: 200,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          const Text('Información personal',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          Container(
                              padding: const EdgeInsets.all(16.0),
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  widget.driver.account!.firstname!,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14))),
                          const SizedBox(height: 16),
                          Container(
                              padding: const EdgeInsets.all(16.0),
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  widget.driver.account!.lastname!)),
                          const SizedBox(height: 16),
                          Container(
                              padding: const EdgeInsets.all(16.0),
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                  "Rol: Driver")),
                          const SizedBox(height: 16),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 10,
                color: const Color.fromRGBO(191, 220, 235, 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      "Información de la licencia",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text(
                            "Tipo de licencia: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Años de experiencia: ${experienceYears.toString()}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 140),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Messages(
                        emitterId: widget.driver.account!.id!,
                        receiverId: userId,
                      ),
                    )
                  );
                },
                child: Text(
                    "Enviar mensaje a ${widget.driver.account!.firstname} ${widget.driver.account!.lastname}")),
          ],
        ),
      ),
    );
  }
}
