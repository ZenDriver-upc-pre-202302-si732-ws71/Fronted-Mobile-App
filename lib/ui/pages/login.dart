import 'package:flutter/material.dart';
import 'package:zendriver/ui/pages/signup_screen.dart';
import 'package:zendriver/ui/shared/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../services/login_service.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  LoginService httpHelper = LoginService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isPasswordVisible = false;
  Future<SharedPreferences>? _prefs;

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    _getToken();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _formKey.currentState?.validate() ?? false;
    });
  }

  void _saveTokenAndUserId(LoginResponse data) async {
    final pref = await _prefs;
    pref?.setString('token', data.token);
    pref?.setString('id', data.id);
  }

  void _getToken() async {
    final pref = await _prefs;
    String? token = pref?.getString('token');
    String? id = pref?.getString('id');
    if (token != null) {
      navigateToHome();
    } else if (id != null) {
      User response = await httpHelper.getUserById(int.parse(id.toString()));
      LoginResponse? response2 = await httpHelper.login(
          response.username.toString(), response.password);
      _saveTokenAndUserId(response2);
      print("loggeado again");
    }
  }

  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Base()),
    );
  }

  void navigateToSignup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  void signIn() async {
    try {
      LoginResponse? response = await httpHelper.login(
          _usernameController.text, _passwordController.text);
      _saveTokenAndUserId(response);
      navigateToHome();
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(50),
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
              const SizedBox(height: 50),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'username',
                  hintText: 'username',
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
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: navigateToSignup,
                    child: const Text('Sign Up'),
                  ),
                  ElevatedButton(
                    onPressed: _isButtonEnabled ? signIn : null,
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
