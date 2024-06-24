import 'package:access_control_flutter/ProfileClient.dart';
import 'package:access_control_flutter/Sign_up.dart';
import 'package:access_control_flutter/Backend%20Tools/importcsv.dart';
import 'package:access_control_flutter/Standard%20Templates/bottom_navbar.dart';
import 'package:access_control_flutter/home_screen.dart';
import 'package:access_control_flutter/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:access_control_flutter/providers/user_provider.dart';
import 'package:access_control_flutter/Admin Side/upload_items.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(), // Create an instance of UserProvider
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Access-Control',
      theme: ThemeData(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const SignUpPage();
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
