import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:user_data/firebase_options.dart';
import 'package:user_data/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

// keytool -genkey -v -keystore E:\testfirebase\android\app\upload-keystore.jks 
//         -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 
//         -alias upload

