import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final IconData icon1;
  final IconData icon2;
  final IconData icon3;
  final IconData icon4;

  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final VoidCallback onTap3;
  final VoidCallback onTap4;

  final int selectedIndex;

  const CustomNavBar({
    super.key,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    required this.icon4,
    required this.onTap1,
    required this.onTap2,
    required this.onTap3,
    required this.onTap4,
    this.selectedIndex = 1,
  });

  BoxShadow? getShadowForIndex(int index, bool isDark) {
    switch (index) {
      case 1:
        return BoxShadow(
          color: Colors.blue.shade200.withAlpha(
            ((isDark ? 0.25 : 0.4) * 255).round(),
          ),
          blurRadius: 12,
          spreadRadius: 2,
          offset: const Offset(0, 4),
        );
      case 2:
        return BoxShadow(
          color: Colors.orange.shade200.withAlpha(
            ((isDark ? 0.25 : 0.4) * 255).round(),
          ),
          blurRadius: 12,
          spreadRadius: 2,
          offset: const Offset(0, 4),
        );
      case 3:
        return BoxShadow(
          color: Colors.purple.shade200.withAlpha(
            ((isDark ? 0.25 : 0.4) * 255).round(),
          ),
          blurRadius: 12,
          spreadRadius: 2,
          offset: const Offset(0, 4),
        );
      case 4:
        return BoxShadow(
          color: Colors.green.shade200.withAlpha(
            ((isDark ? 0.25 : 0.4) * 255).round(),
          ),
          blurRadius: 12,
          spreadRadius: 2,
          offset: const Offset(0, 4),
        );
      default:
        return null;
    }
  }

  Widget _buildIcon(
    IconData icon,
    VoidCallback onTap,
    bool isSelected,
    bool isDark,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                    ? Colors.green.shade800.withAlpha((0.3 * 255).round())
                    : Colors.green.shade100.withAlpha((0.3 * 255).round()))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: isDark
                        ? Colors.green.shade900.withAlpha((0.6 * 255).round())
                        : Colors.green.shade200.withAlpha((0.6 * 255).round()),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: 20,
          color: isSelected
              ? Colors.green.shade400
              : isDark
              ? Colors.white70
              : Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final shadow = getShadowForIndex(selectedIndex, isDark);
    final alpha = (0.9 * 255).round();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey.shade900.withAlpha(alpha)
            : Colors.grey.shade50.withAlpha(alpha),

        borderRadius: BorderRadius.circular(40),
        boxShadow: shadow != null ? [shadow] : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIcon(icon1, onTap1, selectedIndex == 1, isDark),
          _buildIcon(icon2, onTap2, selectedIndex == 2, isDark),
          _buildIcon(icon3, onTap3, selectedIndex == 3, isDark),
          _buildIcon(icon4, onTap4, selectedIndex == 4, isDark),
        ],
      ),
    );
  }
}
