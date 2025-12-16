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
                      Icon(
                        Icons.admin_panel_settings,
                        size: 32,
                        color: colors.onSurface,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Super Admin Dashboard",
                        style: TextStyle(
                          color: colors.onSurface,
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
              // Dealerships
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
              _tableContainer(
                context,
                children: const [
                  TableRowItem(title: "Sunrise Motors", subtitle: "Active"),
                  TableRowItem(title: "Elite Auto Hub", subtitle: "Inactive"),
                  TableRowItem(title: "Prime Wheels", subtitle: "Active"),
                ],
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Drivers
              // ------------------------------------------------
              SectionHeaderWithSearch(
                title: "Drivers",
                searchValue: driverSearch,
                onSearch: (v) => setState(() => driverSearch = v),
                filterValue: driverFilter,
                filterItems: const ["All", "Active", "Inactive"],
                onFilterChanged: (v) => setState(() => driverFilter = v!),
              ),
              _tableContainer(
                context,
                children: const [
                  TableRowItem(title: "John Doe", subtitle: "Active"),
                  TableRowItem(title: "Sarah Kim", subtitle: "Inactive"),
                  TableRowItem(title: "Ravi Kumar", subtitle: "Active"),
                ],
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Vehicles
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
              _tableContainer(
                context,
                children: const [
                  TableRowItem(title: "Toyota Corolla", subtitle: "Active"),
                  TableRowItem(title: "Ford Ranger", subtitle: "Maintenance"),
                  TableRowItem(title: "Honda City", subtitle: "Active"),
                ],
              ),

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
              _tableContainer(
                context,
                children: const [
                  TableRowItem(title: "Brake issue", subtitle: "High Priority"),
                  TableRowItem(title: "Oil leak", subtitle: "Medium Priority"),
                  TableRowItem(title: "AC failure", subtitle: "Low Priority"),
                ],
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Super Admin Tools
              // ------------------------------------------------
              Text(
                "Super Admin Tools",
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _adminTool(
                    context,
                    icon: Icons.manage_accounts,
                    label: "Manage Users",
                  ),
                  const SizedBox(width: 15),
                  _adminTool(
                    context,
                    icon: Icons.settings,
                    label: "System Settings",
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: CustomNavBar(
        selectedIndex: 1,
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

  // ================================================================
  // UI HELPERS
  // ================================================================
  BoxDecoration _boxStyle(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BoxDecoration(
      color: colors.primary,
      borderRadius: BorderRadius.circular(12),
    );
  }

  Widget _tableContainer(
    BuildContext context, {
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxStyle(context),
      child: Column(children: children),
    );
  }

  Widget _adminTool(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _boxStyle(context),
        child: Column(
          children: [
            Icon(icon, color: colors.onPrimary, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              // ignore: deprecated_member_use
              style: TextStyle(color: colors.onPrimary.withOpacity(0.7)),
            ),
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
      width: 85,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: colors.onPrimary, size: 26),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: colors.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              // ignore: deprecated_member_use
              color: colors.onPrimary.withOpacity(0.7),
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------
// SECTION HEADERS
// ------------------------------------------------
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
        Text(title, style: TextStyle(color: colors.onSurface, fontSize: 18)),
        _dropdown(context, filterValue, items, onChanged),
      ],
    );
  }
}

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
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: colors.onSurface, fontSize: 18)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _dropdown(context, filterValue, filterItems, onFilterChanged),
            _dropdown(context, sortValue, sortItems, onSortChanged),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

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
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: colors.onSurface, fontSize: 18)),
        const SizedBox(height: 12),
        TextField(
          style: TextStyle(color: colors.onSurface),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: colors.onSurface),
            hintText: "Search drivers...",
            // ignore: deprecated_member_use
            hintStyle: TextStyle(color: colors.onSurface.withOpacity(0.5)),
            filled: true,
            fillColor: colors.primary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: onSearch,
        ),
        const SizedBox(height: 12),
        _dropdown(context, filterValue, filterItems, onFilterChanged),
        const SizedBox(height: 10),
      ],
    );
  }
}

// ------------------------------------------------
// DROPDOWN
// ------------------------------------------------
Widget _dropdown(
  BuildContext context,
  String value,
  List<String> items,
  ValueChanged<String?> onChanged,
) {
  final colors = Theme.of(context).colorScheme;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: colors.secondary,
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButton<String>(
      value: value,
      underline: const SizedBox(),
      dropdownColor: colors.surface,
      icon: Icon(Icons.arrow_drop_down, color: colors.onSurface),
      style: TextStyle(color: colors.onSurface),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
    ),
  );
}

// ------------------------------------------------
// TABLE ROW
// ------------------------------------------------
class TableRowItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const TableRowItem({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        Icons.circle,
        size: 12,
        // ignore: deprecated_member_use
        color: colors.onSurface.withOpacity(0.6),
      ),
      title: Text(title, style: TextStyle(color: colors.onSurface)),
      subtitle: Text(
        subtitle,
        // ignore: deprecated_member_use
        style: TextStyle(color: colors.onSurface.withOpacity(0.7)),
      ),
    );
  }
}
