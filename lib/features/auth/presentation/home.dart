import 'package:flutter/material.dart';
import '../../../core/services/auth_service.dart';
import 'package:test_case/widget/custom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _signOut() async {
    try {
      await AuthService().signOut();
      // No need to manually navigate — AuthGate handles it
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error signing out: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Yokoso watashi no soul society",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        icon1: Icons.home,
        icon2: Icons.search,
        icon3: Icons.favorite,
        icon4: Icons.logout,
        onTap1: () {},
        onTap2: () {},
        onTap3: () {},
        onTap4: _signOut,
      ),
    );
  }
}
