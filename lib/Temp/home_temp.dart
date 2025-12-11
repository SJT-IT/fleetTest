import 'package:flutter/material.dart';
import 'package:test_case/features/auth/presentation/profile.dart';
import 'package:test_case/widget/custom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Home')),
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
        icon4: Icons.person,
        onTap1: () {
          // handle home tap
        },
        onTap2: () {
          // handle search tap
        },
        onTap3: () {
          // handle favorite tap
        },
        onTap4: () {
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const ProfilePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0); // start from right
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;

                    final tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
            ),
            (route) => false,
          );
        },
        selectedIndex: 1, // currently selected icon (highlight and shadow)
      ),
    );
  }
}
