import 'package:flutter/material.dart';
import 'package:test_case/features/auth/presentation/home.dart';
import 'package:test_case/widget/custom_navbar.dart';
import '../../../core/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _signOut(BuildContext context) async {
    try {
      await authService.value.signOut();

      if (!context.mounted) return;

      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error signing out: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: SizedBox.expand(
        child: Stack(
          children: [
            const Center(
              child: Text(
                "Welcome to your profile",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.6),
              child: SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _signOut(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 119, 119, 119),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: CustomNavBar(
        icon1: Icons.home,
        icon2: Icons.search,
        icon3: Icons.favorite,
        icon4: Icons.person,
        onTap1: () {
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-1.0, 0.0); // start from left
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
        onTap2: () {
          // handle search tap
        },
        onTap3: () {
          // handle favorite tap
        },
        onTap4: () {},
        selectedIndex: 4,
      ),
    );
  }
}
