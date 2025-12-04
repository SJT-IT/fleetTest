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

  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;

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
    this.backgroundColor = Colors.black,
    this.iconColor = Colors.white,
    this.iconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(icon1, color: iconColor, size: iconSize),
            onPressed: onTap1,
          ),
          IconButton(
            icon: Icon(icon2, color: iconColor, size: iconSize),
            onPressed: onTap2,
          ),
          IconButton(
            icon: Icon(icon3, color: iconColor, size: iconSize),
            onPressed: onTap3,
          ),
          IconButton(
            icon: Icon(icon4, color: iconColor, size: iconSize),
            onPressed: onTap4,
          ),
        ],
      ),
    );
  }
}
