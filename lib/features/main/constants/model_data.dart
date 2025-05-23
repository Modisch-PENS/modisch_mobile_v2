import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modisch/features/main/models/menu_models.dart';

class MenuData {
  static List<MenuSection> getMenuSections(BuildContext context,VoidCallback closeMenu) {
    return [
      MenuSection(
        title: 'Clothes',
        items: [
          MenuItem(
            icon: Icons.add,
            iconColor: Colors.pink.shade200,
            label: 'Add Clothes',
            onTap: () {
              debugPrint('Masukkk poll');
              context.go('/add/item/image_picker');
              // closeMenu();
            },
          ),
        ],
      ),
      MenuSection(
        title: 'Outfit',
        items: [
          MenuItem(
            icon: Icons.auto_awesome,
            iconColor: Colors.black,
            label: 'Create idea',
            onTap: () {
              context.go('/add/outfit/canvas');
              // closeMenu();
            },
          ),
          // MenuItem(
          //   icon: Icons.calendar_today,
          //   iconColor: Colors.grey,
          //   label: 'Schedule OOTD',
          //   onTap: () {
          //     // Add navigation logic here
          //     closeMenu();
          //   },
          // ),
        ],
      ),
    ];
  }
}