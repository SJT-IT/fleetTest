import 'package:flutter/material.dart';
import 'package:test_case/features/auth/presentation/profile.dart';
import 'package:test_case/widget/custom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Filters
  String dealershipFilter = "All";
  String dealershipSort = "A-Z";

  String driverFilter = "All";
  String driverSearch = "";

  String vehicleFilter = "All";
  String vehicleDealerFilter = "All";

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
                      Icon(
                        Icons.admin_panel_settings,
                        size: 32,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Super Admin Dashboard",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()),
                    ),
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
              // Summary Cards
              // ------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SummaryCard(
                    label: "Dealerships",
                    value: "8",
                    icon: Icons.store,
                  ),
                  SummaryCard(
                    label: "Drivers",
                    value: "45",
                    icon: Icons.people,
                  ),
                  SummaryCard(
                    label: "Vehicles",
                    value: "120",
                    icon: Icons.local_shipping,
                  ),
                  SummaryCard(
                    label: "Open Complaints",
                    value: "17",
                    icon: Icons.warning,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ------------------------------------------------
              // Dealership List Section
              // ------------------------------------------------
              SectionHeaderDual(
                title: "Dealerships",
                filterValue: dealershipFilter,
                filterItems: const ["All", "Active", "Inactive"],
                sortValue: dealershipSort,
                sortItems: const ["A-Z", "Z-A"],
                onFilterChanged: (v) => setState(() => dealershipFilter = v!),
                onSortChanged: (v) => setState(() => dealershipSort = v!),
              ),
              _dealershipsTable(),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Drivers List Section
              // ------------------------------------------------
              SectionHeaderWithSearch(
                title: "Drivers",
                searchValue: driverSearch,
                onSearch: (v) => setState(() => driverSearch = v),
                filterValue: driverFilter,
                filterItems: const ["All", "Active", "Inactive"],
                onFilterChanged: (v) => setState(() => driverFilter = v!),
              ),
              _driversTable(),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Vehicles Section
              // ------------------------------------------------
              SectionHeaderDual(
                title: "Vehicles",
                filterValue: vehicleFilter,
                filterItems: const ["All", "Active", "Maintenance"],
                sortValue: vehicleDealerFilter,
                sortItems: const ["All", "Dealer A", "Dealer B"],
                onFilterChanged: (v) => setState(() => vehicleFilter = v!),
                onSortChanged: (v) => setState(() => vehicleDealerFilter = v!),
              ),
              _vehiclesTable(),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Complaints Section
              // ------------------------------------------------
              SectionHeader(
                title: "Complaints",
                filterValue: complaintFilter,
                items: const ["All", "High", "Medium", "Low"],
                onChanged: (v) => setState(() => complaintFilter = v!),
              ),
              _complaintsTable(),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Super Admin Tools
              // ------------------------------------------------
              const Text(
                "Super Admin Tools",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _adminTool(
                    icon: Icons.manage_accounts,
                    label: "Manage Users",
                  ),
                  const SizedBox(width: 15),
                  _adminTool(icon: Icons.settings, label: "System Settings"),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: CustomNavBar(
        selectedIndex: 0,
        icon1: Icons.home,
        icon2: Icons.search,
        icon3: Icons.favorite,
        icon4: Icons.person,
        onTap1: () {},
        onTap2: () {},
        onTap3: () {},
        onTap4: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfilePage()),
        ),
      ),
    );
  }

  // ==============================
  // DEALERSHIP TABLE
  // ==============================
  Widget _dealershipsTable() {
    return _tableContainer(
      children: const [
        TableRowItem(title: "Sunrise Motors", subtitle: "Active"),
        TableRowItem(title: "Elite Auto Hub", subtitle: "Inactive"),
        TableRowItem(title: "Prime Wheels", subtitle: "Active"),
      ],
    );
  }

  // ==============================
  // DRIVERS TABLE
  // ==============================
  Widget _driversTable() {
    return _tableContainer(
      children: const [
        TableRowItem(title: "John Doe", subtitle: "Active"),
        TableRowItem(title: "Sarah Kim", subtitle: "Inactive"),
        TableRowItem(title: "Ravi Kumar", subtitle: "Active"),
      ],
    );
  }

  // ==============================
  // VEHICLES TABLE
  // ==============================
  Widget _vehiclesTable() {
    return _tableContainer(
      children: const [
        TableRowItem(title: "Toyota Corolla", subtitle: "Active"),
        TableRowItem(title: "Ford Ranger", subtitle: "Maintenance"),
        TableRowItem(title: "Honda City", subtitle: "Active"),
      ],
    );
  }

  // ==============================
  // COMPLAINTS TABLE
  // ==============================
  Widget _complaintsTable() {
    return _tableContainer(
      children: const [
        TableRowItem(title: "Brake issue", subtitle: "High Priority"),
        TableRowItem(title: "Oil leak", subtitle: "Medium Priority"),
        TableRowItem(title: "AC failure", subtitle: "Low Priority"),
      ],
    );
  }

  // ==============================
  // UI HELPERS
  // ==============================
  Widget _tableContainer({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  Widget _adminTool({required IconData icon, required String label}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

//
// ─────────────────────────────────────────────
// REUSABLE WIDGETS
// ─────────────────────────────────────────────
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
      width: 85,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Basic Section Header with single dropdown
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
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
        _dropdown(filterValue, items, onChanged),
      ],
    );
  }
}

// Section header with Filter + Sort
class SectionHeaderDual extends StatelessWidget {
  final String title;
  final String filterValue;
  final List<String> filterItems;
  final String sortValue;
  final List<String> sortItems;
  final ValueChanged<String?> onFilterChanged;
  final ValueChanged<String?> onSortChanged;

  const SectionHeaderDual({
    super.key,
    required this.title,
    required this.filterValue,
    required this.filterItems,
    required this.sortValue,
    required this.sortItems,
    required this.onFilterChanged,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _dropdown(filterValue, filterItems, onFilterChanged),
            _dropdown(sortValue, sortItems, onSortChanged),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

// Section header with search + filter
class SectionHeaderWithSearch extends StatelessWidget {
  final String title;
  final String searchValue;
  final Function(String) onSearch;
  final String filterValue;
  final List<String> filterItems;
  final ValueChanged<String?> onFilterChanged;

  const SectionHeaderWithSearch({
    super.key,
    required this.title,
    required this.searchValue,
    required this.onSearch,
    required this.filterValue,
    required this.filterItems,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 12),
        TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: Colors.white70),
            hintText: "Search drivers...",
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: onSearch,
        ),
        const SizedBox(height: 12),
        _dropdown(filterValue, filterItems, onFilterChanged),
        const SizedBox(height: 10),
      ],
    );
  }
}

// Dropdown widget
Widget _dropdown(
  String value,
  List<String> items,
  ValueChanged<String?> onChanged,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.grey[850],
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButton<String>(
      value: value,
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
  );
}

// Table row widget
class TableRowItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const TableRowItem({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      leading: const Icon(Icons.circle, size: 12, color: Colors.white70),
    );
  }
}
