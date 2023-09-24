import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:zendriver/services/user_sign_up_service.dart';
import '../../models/user.dart';
import '../../models/user_sign_up.dart';
import '../../services/login_service.dart';
import 'login.dart';

String _twoDigits(int n) {
  if (n >= 10) {
    return "$n";
  }
  return "0$n";
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  UserSignUpService httpHelper = UserSignUpService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  DateTime _dateTime = DateTime.now();

  bool _isButtonEnabled = false;
  bool _isPasswordVisible = false;
  bool _isPasswordConfirmVisible = false;
  String _role = 'driver';


  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //_role = 'driver';
    _roleController.text = _role;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _formKey.currentState?.validate() ?? false;
    });
  }
   void navigateToSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SigninScreen()),
    );
  }

  void returnToSignIn(SignupResponse response) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Message'),
          content: Text(response.message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void signUp() async { 
    try {
      UserSignUp user = UserSignUp(
          firstname: _firstNameController.text,
          lastname: _lastNameController.text,
          username: _usernameController.text,
          password: _passwordController.text,
          phone: '-',
          role: _roleController.text,
          recruiter: _roleController.text == "recruiter" ?  Recruiter(
            email: '-',
            description: '-',
            companyId: 1
            ) : null,
          driver: _roleController.text == "driver" ?  Driver(
            address: 'Lima',
            birth: '1990-09-23T19:28:53.298Z'
            ) : null
        );
      print('---------------------user register-------------');
      print(user.toJson());
      SignupResponse response = await httpHelper.signUp(user);
      print('---------------------user response-------------');
      print(response);
      returnToSignIn(response);
      navigateToSignIn();
    } catch (e) {
      String message = e.toString().split(':')[1].trim();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    List<bool> selections = [false, false];
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        onChanged: _validateForm,
        child: Column(
          children: [
            ClipOval(
                child: Image.asset(
              'assets/logo.png',
              height: size.height * 0.25,
            )),
            const SizedBox(height: 30),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                hintText: 'Enter your first name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                hintText: 'Enter your last name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            /* ElevatedButton.icon(
              icon: const Icon(
                Icons.calendar_today,
                color: Colors.green,
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(400, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _showDatePicker();
              },
              label: const Text("Seleccionar Fecha de nacimiento"),
            ), */
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'username',
                hintText: 'Enter your username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              obscureText: !_isPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordConfirmController,
              decoration: InputDecoration(
                labelText: 'Confirm your password',
                hintText: 'Confirm your password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordConfirmVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordConfirmVisible = !_isPasswordConfirmVisible;
                    });
                  },
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              obscureText: !_isPasswordConfirmVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords don\'t match';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            AnimatedToggleSwitch<String>.dual(
                current: _role,
                first: "recruiter",
                second: "driver",
                dif: 50.0,
                borderColor: Colors.transparent,
                borderWidth: 5.0,
                height: 55,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _role = value;
                    /* if(_role == 'recruiter'){
                      _roleController.text = 'driver';
                    }
                    else{
                      _roleController.text = 'recruiter';
                    } */
                    _roleController.text = value;
                    print(_roleController.text);
                  });
                  
                  return Future.delayed(const Duration(seconds: 1));

                },
                colorBuilder: (value) => _role == "recruiter" ? Colors.blue : Colors.green,
                iconBuilder: (value) => value == "recruiter"
                    ? const Icon(Icons.person)
                    : const Icon(Icons.drive_eta_rounded),
                textBuilder: (value) => value == "recruiter"
                    ? const Center(child: Text('Recuiter'))
                    : const Center(child: Text('Driver')),
              ),
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonEnabled ? signUp : null,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    ));
  }
}
