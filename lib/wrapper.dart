import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:test_case/features/driver/presentation/home_driver_temp.dart'
    as driver;
import 'package:test_case/features/dealer/presentation/home_dealer_temp.dart'
    as dealer;
import 'package:test_case/features/superadmin/presentation/home_admin_temp.dart'
    as superadmin;

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: Text('No user logged in')));
    }

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(body: Center(child: Text('User not found')));
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final role = userData['role'] ?? 'driver';

        switch (role) {
          case 'driver':
            return const driver.HomePage();
          case 'dealer':
            return const dealer.HomePage();
          case 'superadmin':
            return const superadmin.HomePage();
          default:
            return Scaffold(
              body: Center(
                child: Text(
                  'Role not recognized',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            );
        }
      },
    );
  }
}
