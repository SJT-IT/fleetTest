// lib/app/app.dart
import 'package:flutter/material.dart';
import '../features/auth/presentation/login.dart';
import '../features/auth/presentation/signup.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Name',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}
