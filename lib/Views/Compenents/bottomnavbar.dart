import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [BottomNavigationBarItem(icon: Icon(Iconsax.home))],
      backgroundColor: Colors.grey.withOpacity(0.1),
      currentIndex: 1,
    );
  }
}
