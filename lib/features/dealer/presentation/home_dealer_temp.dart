import 'package:flutter/material.dart';
import 'package:test_case/features/auth/presentation/profile.dart';
import 'package:test_case/widget/custom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String driverFilter = "All";
  String vehicleFilter = "All";
  String complaintFilter = "All";

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------------------------------------
              // Header
              // ------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.dashboard, color: colors.onSurface, size: 32),
                      const SizedBox(width: 10),
                      Text(
                        "Admin Dashboard",
                        style: TextStyle(
                          color: colors.onSurface,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProfilePage()),
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

              const SizedBox(height: 20),

              // ------------------------------------------------
              // Summary Cards
              // ------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SummaryCard(
                    label: "Total Drivers",
                    value: "12",
                    icon: Icons.people,
                  ),
                  SummaryCard(
                    label: "Vehicles",
                    value: "8 Active / 2 Maint",
                    icon: Icons.local_shipping,
                  ),
                  SummaryCard(
                    label: "Open Complaints",
                    value: "5",
                    icon: Icons.report_problem,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ------------------------------------------------
              // Driver List
              // ------------------------------------------------
              SectionHeader(
                title: "Driver List",
                filterValue: driverFilter,
                items: const ["All", "Active", "Inactive"],
                onChanged: (v) => setState(() => driverFilter = v!),
              ),
              _driverList(context),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Vehicle List
              // ------------------------------------------------
              SectionHeader(
                title: "Vehicle List",
                filterValue: vehicleFilter,
                items: const ["All", "Active", "Maintenance"],
                onChanged: (v) => setState(() => vehicleFilter = v!),
              ),
              _vehicleList(context),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Complaints
              // ------------------------------------------------
              SectionHeader(
                title: "Complaints",
                filterValue: complaintFilter,
                items: const ["All", "High", "Medium", "Low"],
                onChanged: (v) => setState(() => complaintFilter = v!),
              ),
              _complaintsList(context),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Quick Actions
              // ------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _quickAction(
                    context,
                    icon: Icons.assignment_add,
                    label: "Assign Complaint",
                  ),
                  _quickAction(
                    context,
                    icon: Icons.build,
                    label: "Update Vehicle",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Bottom Nav
      bottomNavigationBar: CustomNavBar(
        icon1: Icons.home,
        icon2: Icons.search,
        icon3: Icons.favorite,
        icon4: Icons.person,
        onTap1: () {},
        onTap2: () {},
        onTap3: () {},
        onTap4: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfilePage()),
          );
        },
        selectedIndex: 1,
      ),
    );
  }

  // ================================================================
  // Reusable Box Style
  // ================================================================
  BoxDecoration _boxStyle(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BoxDecoration(
      color: colors.primary,
      borderRadius: BorderRadius.circular(12),
    );
  }

  // ================================================================
  // Lists
  // ================================================================
  Widget _driverList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxStyle(context),
      child: const Column(
        children: [
          DriverRow(name: "John Doe", status: "Active"),
          DriverRow(name: "Sam Patel", status: "Inactive"),
          DriverRow(name: "Alice Sam", status: "Active"),
        ],
      ),
    );
  }

  Widget _vehicleList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxStyle(context),
      child: const Column(
        children: [
          VehicleRow(model: "Toyota Corolla", status: "Active"),
          VehicleRow(model: "Ford F-150", status: "Maintenance"),
          VehicleRow(model: "Honda Civic", status: "Active"),
        ],
      ),
    );
  }

  Widget _complaintsList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxStyle(context),
      child: const Column(
        children: [
          ComplaintRow(issue: "Brake issue", priority: "High"),
          ComplaintRow(issue: "AC failure", priority: "Medium"),
          ComplaintRow(issue: "Noise issue", priority: "Low"),
        ],
      ),
    );
  }

  // ================================================================
  // Quick Action
  // ================================================================
  Widget _quickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    final colors = Theme.of(context).colorScheme;

    // ignore: deprecated_member_use
    var withOpacity = colors.onPrimary.withOpacity(0.7);
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: _boxStyle(context),
      child: Column(
        children: [
          Icon(icon, color: colors.onPrimary),
          const SizedBox(height: 6),
          Text(
            label,
            // ignore: deprecated_member_use
            style: TextStyle(color: withOpacity),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// REUSABLE WIDGETS
// ──────────────────────────────────────────────────────────────

class SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const SummaryCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 110,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: colors.onPrimary),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: colors.onPrimary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
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
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String filterValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const SectionHeader({
    super.key,
    required this.title,
    required this.filterValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: colors.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: filterValue,
            underline: const SizedBox(),
            dropdownColor: colors.surface,
            icon: Icon(Icons.arrow_drop_down, color: colors.onSurface),
            style: TextStyle(color: colors.onSurface),
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class DriverRow extends StatelessWidget {
  final String name;
  final String status;

  const DriverRow({super.key, required this.name, required this.status});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(Icons.person, color: colors.onSurface),
      title: Text(name, style: TextStyle(color: colors.onSurface)),
      subtitle: Text(
        status,
        // ignore: deprecated_member_use
        style: TextStyle(color: colors.onSurface.withOpacity(0.7)),
      ),
    );
  }
}

class VehicleRow extends StatelessWidget {
  final String model;
  final String status;

  const VehicleRow({super.key, required this.model, required this.status});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(Icons.local_shipping, color: colors.onSurface),
      title: Text(model, style: TextStyle(color: colors.onSurface)),
      subtitle: Text(
        status,
        style: TextStyle(
          color: status == "Maintenance"
              ? Colors.redAccent
              : Colors.greenAccent,
        ),
      ),
    );
  }
}

class ComplaintRow extends StatelessWidget {
  final String issue;
  final String priority;

  const ComplaintRow({super.key, required this.issue, required this.priority});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final Color priorityColor = priority == "High"
        ? Colors.redAccent
        : priority == "Medium"
        ? Colors.orangeAccent
        : Colors.greenAccent;

    return ListTile(
      leading: Icon(Icons.warning, color: colors.onSurface),
      title: Text(issue, style: TextStyle(color: colors.onSurface)),
      subtitle: Text(
        "Priority: $priority",
        style: TextStyle(color: priorityColor),
      ),
    );
  }
}
