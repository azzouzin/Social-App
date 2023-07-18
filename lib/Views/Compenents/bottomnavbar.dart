import 'package:firebase/Controllers/State%20Managment/navigation_manag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavBar extends StatelessWidget {
  NavController navController = Get.put(NavController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
        currentIndex: navController.selectedIndex.value,
        onTap: (index) {
          print(index);
          navController.gotopage(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Iconsax.home_15,
                color: navController.currentpageclr[0],
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Iconsax.message,
                color: navController.currentpageclr[1],
              ),
              label: 'Chats'),
          BottomNavigationBarItem(
              icon: Icon(
                Iconsax.add,
                color: navController.currentpageclr[2],
              ),
              label: 'add'),
          BottomNavigationBarItem(
              icon: Icon(
                Iconsax.setting5,
                color: navController.currentpageclr[3],
              ),
              label: 'settings'),
        ],
        backgroundColor: Colors.grey.withOpacity(0.1),
        unselectedLabelStyle:
            const TextStyle(color: Colors.black, fontSize: 14),
        fixedColor: Colors.black,
      );
    });
  }
}
