import 'dart:ui';

import 'package:access_control_flutter/Sign_up.dart';
import 'package:access_control_flutter/Standard%20Templates/Text_field_login.dart';
import 'package:access_control_flutter/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:access_control_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginData {
  final String email;
  final String password;

  LoginData({required this.email, required this.password});
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();
  static Future login() => _googleSignIn.signIn();
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late UserProvider userProvider; // Declare the userProvider variable

  Future signIn() async {
    await GoogleSignInApi.login();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginWithEmailAndPassword(BuildContext context) async {
    try {
      final authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      userProvider.fetchUserDataFromBackend(); // Fetch user data after successful login

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } catch (error) {
      print("Error: $error");

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(
            children: [
              // Background screen
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              // Dialog box
              AlertDialog(
                title: const Text(
                  'Login Failed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'The email or password you entered is incorrect.',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Container(
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(236, 179, 101, 1),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: const Color.fromRGBO(4, 28, 50, 1),
                elevation: 10,
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context, listen: false); // Retrieve the userProvider instance

    return Scaffold(
      backgroundColor:
          const Color.fromRGBO(4, 28, 50, 1), // Set background color to white
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                "assets/AIOT.jpg",
                fit: BoxFit.cover,
                width:
                    2 * 100, // Double the radius value to get the desired width
                height:
                    2 * 90, // Double the radius value to get the desired height
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(
                    4, 41, 58, 1), // Set container color to grey
                borderRadius: BorderRadius.circular(21.0),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 36, 34, 34).withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 10), // changes position of shadow
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    reusabelTextField(
                        'Email', Icons.person_outline, false, _emailController),
                    const SizedBox(height: 16.0),
                    reusabelTextField('Password', Icons.lock_outline, true,
                        _passwordController),
                    const SizedBox(height: 16.0),
                    signInButton(context, () {
                      _loginWithEmailAndPassword(context);
                    }),
                    const SizedBox(height: 8.0),
                    TextButton(
                      onPressed: () {
                        // Forgot password functionality
                      },
                      child: const Text('Forgot Password?',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(4, 41, 58, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 0),
                        Image.asset(
                          'assets/google_logo.png',
                          height: 50.0,
                          width: 50.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 8.0),
                        const Text(
                          'Sign In with Google',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: const Color.fromRGBO(4, 41, 58, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 10,
                    ),
                    child: const Text(
                      'New User ? Create an Account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
