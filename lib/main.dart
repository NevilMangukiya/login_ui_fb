import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_ui_fb/screens/home_page.dart';
import 'package:login_ui_fb/screens/login_page.dart';
import 'package:login_ui_fb/screens/signup_page.dart';
import 'package:login_ui_fb/screens/splash_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "splash_screen",
      routes: {
        '/': (context) => const HomePage(),
        'login_page': (context) => const LoginPage(),
        'splash_screen': (context) => const IntroScreen(),
        'sign_up': (context) => const SignUpPage(),
      },
    ),
  );
}
