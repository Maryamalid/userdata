import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:user_data/screens/home_screen.dart';
import 'package:user_data/screens/login_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isloggedIn = false;

  @override
  void initState() {
    listenToUser();
    super.initState();
  }

  void listenToUser() {
    // الاستماع إلى تغييرات حالة المستخدم من Firebase Authentication
    Stream<User?> stream = FirebaseAuth.instance.authStateChanges();

    stream.listen((User? user) {
      print("User: ${user.toString()}"); // طباعة بيانات المستخدم

      if (user == null) {
        isloggedIn = false; // المستخدم غير مسجل الدخول
      } else {
        isloggedIn = true; // المستخدم مسجل الدخول
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isloggedIn) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
