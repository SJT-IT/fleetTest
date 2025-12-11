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
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------------------------------------
              // Header (Logo + Profile)
              // ------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.dashboard, color: Colors.white, size: 32),
                      SizedBox(width: 10),
                      Text(
                        "Admin Dashboard",
                        style: TextStyle(
                          color: Colors.white,
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
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // Summary Cards (Top Row)
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
              // Driver List Section
              // ------------------------------------------------
              SectionHeader(
                title: "Driver List",
                filterValue: driverFilter,
                items: const ["All", "Active", "Inactive"],
                onChanged: (v) => setState(() => driverFilter = v!),
              ),
              _driverList(),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Vehicle List Section
              // ------------------------------------------------
              SectionHeader(
                title: "Vehicle List",
                filterValue: vehicleFilter,
                items: const ["All", "Active", "Maintenance"],
                onChanged: (v) => setState(() => vehicleFilter = v!),
              ),
              _vehicleList(),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Complaints List Section
              // ------------------------------------------------
              SectionHeader(
                title: "Complaints",
                filterValue: complaintFilter,
                items: const ["All", "High", "Medium", "Low"],
                onChanged: (v) => setState(() => complaintFilter = v!),
              ),
              _complaintsList(),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Quick Actions (Optional)
              // ------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _quickAction(
                    icon: Icons.assignment_add,
                    label: "Assign Complaint",
                  ),
                  _quickAction(icon: Icons.build, label: "Update Vehicle"),
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
  // Driver List Widget
  // ================================================================
  Widget _driverList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxStyle(),
      child: Column(
        children: const [
          DriverRow(name: "John Doe", status: "Active"),
          DriverRow(name: "Sam Patel", status: "Inactive"),
          DriverRow(name: "Alice Sam", status: "Active"),
        ],
      ),
    );
  }

  // ================================================================
  // Vehicle List Widget
  // ================================================================
  Widget _vehicleList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxStyle(),
      child: Column(
        children: const [
          VehicleRow(model: "Toyota Corolla", status: "Active"),
          VehicleRow(model: "Ford F-150", status: "Maintenance"),
          VehicleRow(model: "Honda Civic", status: "Active"),
        ],
      ),
    );
  }

  // ================================================================
  // Complaints List Widget
  // ================================================================
  Widget _complaintsList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxStyle(),
      child: Column(
        children: const [
          ComplaintRow(issue: "Brake issue", priority: "High"),
          ComplaintRow(issue: "AC failure", priority: "Medium"),
          ComplaintRow(issue: "Noise issue", priority: "Low"),
        ],
      ),
    );
  }

  // Reusable style
  BoxDecoration _boxStyle() => BoxDecoration(
    color: Colors.grey[900],
    borderRadius: BorderRadius.circular(12),
  );

  // Quick Actions
  Widget _quickAction({required IconData icon, required String label}) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: _boxStyle(),
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

//
// ──────────────────────────────────────────────────────────────
//   REUSABLE WIDGETS
// ──────────────────────────────────────────────────────────────
//

// Summary Card
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
    return Container(
      width: 110,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Section header with filter dropdown
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: filterValue,
            underline: const SizedBox(),
            dropdownColor: Colors.grey[900],
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            style: const TextStyle(color: Colors.white),
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: const TextStyle(color: Colors.white)),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

// Rows for driver list
class DriverRow extends StatelessWidget {
  final String name;
  final String status;

  const DriverRow({super.key, required this.name, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name, style: const TextStyle(color: Colors.white)),
      subtitle: Text(status, style: const TextStyle(color: Colors.white70)),
      leading: const Icon(Icons.person, color: Colors.white),
    );
  }
}

// Rows for vehicles
class VehicleRow extends StatelessWidget {
  final String model;
  final String status;

  const VehicleRow({super.key, required this.model, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model, style: const TextStyle(color: Colors.white)),
      subtitle: Text(
        status,
        style: TextStyle(
          color: status == "Maintenance"
              ? Colors.redAccent
              : Colors.greenAccent,
        ),
      ),
      leading: const Icon(Icons.local_shipping, color: Colors.white),
    );
  }
}

// Rows for complaints
class ComplaintRow extends StatelessWidget {
  final String issue;
  final String priority;

  const ComplaintRow({super.key, required this.issue, required this.priority});

  @override
  Widget build(BuildContext context) {
    Color color = priority == "High"
        ? Colors.redAccent
        : priority == "Medium"
        ? Colors.orangeAccent
        : Colors.greenAccent;

    return ListTile(
      title: Text(issue, style: const TextStyle(color: Colors.white)),
      subtitle: Text("Priority: $priority", style: TextStyle(color: color)),
      leading: const Icon(Icons.warning, color: Colors.white),
    );
  }
}
