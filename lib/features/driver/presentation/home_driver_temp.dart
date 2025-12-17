import 'package:flutter/material.dart';
import 'package:test_case/features/auth/presentation/profile.dart';
import 'package:test_case/widget/custom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.only(
              bottom: 80,
            ), // Reserve space for floating navbar
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ------------------------------------------------
                    // Header: App Logo + Profile
                    // ------------------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.car_rental,
                              size: 32,
                              color: colors.onSurface,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "FleetApp",
                              style: TextStyle(
                                color: colors.onSurface,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProfilePage(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: colors.primary,
                            child: Icon(Icons.person, color: colors.onPrimary),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // ------------------------------------------------
                    // Assigned Vehicle Card
                    // ------------------------------------------------
                    _infoCard(
                      context,
                      title: "Assigned Vehicle",
                      children: [
                        Text(
                          "Toyota Corolla 2021",
                          style: _titleStyle(context),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Reg No: ABC-1234",
                          style: _subtitleStyle(context),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Status: Active",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ------------------------------------------------
                    // Dealership Info Card
                    // ------------------------------------------------
                    _infoCard(
                      context,
                      title: "Dealership Info",
                      children: [
                        Text(
                          "Sunrise Motors",
                          style: _titleStyle(context, size: 18),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Contact: +91 9876543210",
                          style: _subtitleStyle(context),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // ------------------------------------------------
                    // Quick Actions Row
                    // ------------------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _quickActionButton(
                          context,
                          icon: Icons.report_problem,
                          label: "Report Issue",
                        ),
                        _quickActionButton(
                          context,
                          icon: Icons.list_alt,
                          label: "My Complaints",
                        ),
                        _quickActionButton(
                          context,
                          icon: Icons.support_agent,
                          label: "Support",
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // ------------------------------------------------
                    // Complaint Stats
                    // ------------------------------------------------
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: _boxStyle(context),
                      child: Column(
                        children: const [
                          Text(
                            "Complaint Status",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _StatBox(label: "Pending", number: 2),
                              _StatBox(label: "In Progress", number: 1),
                              _StatBox(label: "Resolved", number: 5),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ------------------------------------------------
          // Floating CustomNavBar
          // ------------------------------------------------
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
              onTap1: () => setState(() => selectedIndex = 1),
              onTap2: () => setState(() => selectedIndex = 2),
              onTap3: () => setState(() => selectedIndex = 3),
              onTap4: () {
                setState(() => selectedIndex = 4);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, _, _) => const ProfilePage(),
                    transitionsBuilder: (_, animation, _, child) {
                      final tween = Tween(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeInOut));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// Reusable Styles & Widgets
// ================================================================
BoxDecoration _boxStyle(BuildContext context) {
  final colors = Theme.of(context).colorScheme;

  return BoxDecoration(
    color: colors.primary,
    borderRadius: BorderRadius.circular(12),
  );
}

TextStyle _titleStyle(BuildContext context, {double size = 20}) {
  final colors = Theme.of(context).colorScheme;

  return TextStyle(
    color: colors.onPrimary,
    fontSize: size,
    fontWeight: FontWeight.bold,
  );
}

TextStyle _subtitleStyle(BuildContext context) {
  final colors = Theme.of(context).colorScheme;

  // ignore: deprecated_member_use
  return TextStyle(color: colors.onPrimary.withOpacity(0.7), fontSize: 16);
}

Widget _infoCard(
  BuildContext context, {
  required String title,
  required List<Widget> children,
}) {
  final colors = Theme.of(context).colorScheme;

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: _boxStyle(context),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            // ignore: deprecated_member_use
            color: colors.onPrimary.withOpacity(0.7),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        ...children,
      ],
    ),
  );
}

Widget _quickActionButton(
  BuildContext context, {
  required IconData icon,
  required String label,
}) {
  final colors = Theme.of(context).colorScheme;

  return Container(
    width: 100,
    padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: _boxStyle(context),
    child: Column(
      children: [
        Icon(icon, color: colors.onPrimary),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            // ignore: deprecated_member_use
            color: colors.onPrimary.withOpacity(0.7),
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// ------------------------------------------------
// Complaint Stats Component
// ------------------------------------------------
class _StatBox extends StatelessWidget {
  final String label;
  final int number;

  const _StatBox({required this.label, required this.number});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          number.toString(),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: colors.onPrimary,
          ),
        ),
        const SizedBox(height: 4),
        // ignore: deprecated_member_use
        Text(label, style: TextStyle(color: colors.onPrimary.withOpacity(0.7))),
      ],
    );
  }
}
