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
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        elevation: 0,
      ),
      body: _buildProfileStack(context, _signOut),
      bottomNavigationBar: CustomNavBar(
        icon1: Icons.home,
        icon2: Icons.search,
        icon3: Icons.favorite,
        icon4: Icons.person,
        onTap1: () {
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const HomeWrapper(),
              transitionsBuilder: (_, animation, __, child) {
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
        selectedIndex: 4,
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
  final colors = Theme.of(context).colorScheme;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: colors.surface,
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
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Are you sure you want to log out?",
              style: TextStyle(
                fontSize: 15,
                // ignore: deprecated_member_use
                color: colors.onSurface.withOpacity(0.7),
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
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
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
  final colors = Theme.of(context).colorScheme;

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        // ------------------------------------------------
        // Profile Card
        // ------------------------------------------------
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
                        color: colors.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Welcome to California",
                      style: TextStyle(
                        // ignore: deprecated_member_use
                        color: colors.onPrimary.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit, color: colors.onPrimary),
                onPressed: () {},
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // ------------------------------------------------
        // Settings Card (Theme Toggle)
        // ------------------------------------------------
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: _cardStyle(context),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.dark_mode, color: colors.onPrimary),
                title: Text(
                  "Dark Mode",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: colors.onPrimary,
                  ),
                ),
                trailing: Switch(
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onChanged: (_) {
                    Provider.of<ThemeProvider>(
                      context,
                      listen: false,
                    ).toggleTheme();
                  },
                ),
              ),
              _divider(),
              _buildListTile(context, Icons.person, "Account Details"),
              _divider(),
              _buildListTile(context, Icons.payment, "Payment History"),
              _divider(),
              _buildListTile(context, Icons.notifications, "Notification"),
              _divider(),
              _buildListTile(context, Icons.settings, "Settings"),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // ------------------------------------------------
        // Support & Logout
        // ------------------------------------------------
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: _cardStyle(context),
          child: Column(
            children: [
              _buildListTile(context, Icons.phone, "Contact Us"),
              _divider(),
              _buildListTile(context, Icons.description, "Terms & Conditions"),
              _divider(),
              _buildListTile(context, Icons.lock, "Privacy Policy"),
              _divider(),
              _buildListTile(context, Icons.help_outline, "Get Help"),
              _divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text(
                  "Log Out",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.redAccent,
                ),
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
  final colors = Theme.of(context).colorScheme;

  return BoxDecoration(
    color: colors.primary,
    borderRadius: BorderRadius.circular(16),
  );
}

Widget _buildListTile(BuildContext context, IconData icon, String title) {
  final colors = Theme.of(context).colorScheme;

  return ListTile(
    leading: Icon(icon, color: colors.onPrimary),
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w500, color: colors.onPrimary),
    ),
    trailing: Icon(Icons.chevron_right, color: colors.onPrimary),
    onTap: () {},
  );
}

Widget _divider() {
  return const Divider(height: 1, indent: 16, endIndent: 16);
}
