import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_case/features/auth/presentation/home.dart';
import 'package:test_case/features/auth/presentation/login.dart';
import 'package:test_case/features/auth/presentation/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),

      // Register your routes
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

/// Gatekeeper that decides where to go based on login state
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // No user signed in → go to Login
        if (!snapshot.hasData) {
          return const LoginPage();
        }

        // User is signed in → go to Home
        return const HomePage();
      },
    );
  }
}
