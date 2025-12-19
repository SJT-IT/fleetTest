import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_case/main.dart';
import 'package:test_case/widget/custom_navbar.dart';
import 'package:test_case/wrapper.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    int selectedIndex = 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: _buildProfileStack(context, _signOut),
          ),

          // Floating CustomNavBar
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: CustomNavBar(
              icon1: Icons.home,
              icon2: Icons.search,
              icon3: Icons.favorite,
              icon4: Icons.person,
              selectedIndex: selectedIndex,
              onTap1: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, _, _) => const HomeWrapper(),
                    transitionsBuilder: (_, animation, _, child) {
                      final tween = Tween(
                        begin: const Offset(-1.0, 0.0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeInOut));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                  (route) => false,
                );
              },
              onTap2: () {},
              onTap3: () {},
              onTap4: () {},
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// LOGOUT CONFIRMATION
// ================================================================

void showLogoutConfirmation(
  BuildContext context,
  Function(BuildContext) signOut,
) {
  final colorScheme = Theme.of(context).colorScheme;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Logout",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Are you sure you want to log out?",
              style: TextStyle(
                fontSize: 15,
                color: colorScheme.onSurface.withAlpha(7),
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      foregroundColor: colorScheme.primary,
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      signOut(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.error,
                      foregroundColor: colorScheme.onError,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Yes, Logout"),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

// ================================================================
// PROFILE BODY
// ================================================================

Widget _buildProfileStack(
  BuildContext context,
  Function(BuildContext) signOut,
) {
  final colorScheme = Theme.of(context).colorScheme;

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        // Profile Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: _cardStyle(context),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage("assets/images/profile.png"),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mr. Jacob",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text("Welcome to California", style: TextStyle()),
                  ],
                ),
              ),
              IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Settings Card
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: _cardStyle(context),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.dark_mode),
                title: Text(
                  "Dark Mode",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: Switch(
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onChanged: (_) {
                    Provider.of<ThemeProvider>(
                      context,
                      listen: false,
                    ).toggleTheme();
                  },
                  activeThumbColor: colorScheme.secondary,
                ),
              ),
              _divider(colorScheme),
              _buildListTile(
                context,
                Icons.person,
                "Account Details",
                colorScheme,
              ),
              _divider(colorScheme),
              _buildListTile(
                context,
                Icons.payment,
                "Payment History",
                colorScheme,
              ),
              _divider(colorScheme),
              _buildListTile(
                context,
                Icons.notifications,
                "Notification",
                colorScheme,
              ),
              _divider(colorScheme),
              _buildListTile(context, Icons.settings, "Settings", colorScheme),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Support & Logout
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: _cardStyle(context),
          child: Column(
            children: [
              _buildListTile(context, Icons.phone, "Contact Us", colorScheme),
              _divider(colorScheme),
              _buildListTile(
                context,
                Icons.description,
                "Terms & Conditions",
                colorScheme,
              ),
              _divider(colorScheme),
              _buildListTile(
                context,
                Icons.lock,
                "Privacy Policy",
                colorScheme,
              ),
              _divider(colorScheme),
              _buildListTile(
                context,
                Icons.help_outline,
                "Get Help",
                colorScheme,
              ),
              _divider(colorScheme),
              ListTile(
                leading: Icon(Icons.logout, color: colorScheme.error),
                title: Text(
                  "Log Out",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.error,
                  ),
                ),
                trailing: Icon(Icons.chevron_right, color: colorScheme.error),
                onTap: () => showLogoutConfirmation(context, signOut),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ================================================================
// HELPERS
// ================================================================

BoxDecoration _cardStyle(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;

  return BoxDecoration(
    color: colorScheme.surface, // Use surface instead of primary for cards
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: colorScheme.onSurface.withAlpha(1),
        offset: const Offset(0, 2),
        blurRadius: 4,
      ),
    ],
  );
}

Widget _buildListTile(
  BuildContext context,
  IconData icon,
  String title,
  ColorScheme colorScheme,
) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
    trailing: Icon(Icons.chevron_right, color: colorScheme.onPrimary),
    onTap: () {},
  );
}

Widget _divider(ColorScheme colorScheme) {
  return Divider(
    height: 1,
    indent: 16,
    endIndent: 16,
    color: colorScheme.onSurface.withAlpha(3),
  );
}
