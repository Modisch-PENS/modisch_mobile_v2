import 'package:flutter/material.dart';
import 'package:modisch/features/main/models/menu_models.dart';

class MenuData {
  static List<MenuSection> getMenuSections(VoidCallback closeMenu) {
    return [
      MenuSection(
        title: 'Clothes',
        items: [
          MenuItem(
            icon: Icons.add,
            iconColor: Colors.pink.shade200,
            label: 'Add Clothes',
            onTap: () {
              // Add navigation logic here
              closeMenu();
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
              // Add navigation logic here
              closeMenu();
            },
          ),
          MenuItem(
            icon: Icons.calendar_today,
            iconColor: Colors.grey,
            label: 'Schedule OOTD',
            onTap: () {
              // Add navigation logic here
              closeMenu();
            },
          ),
        ],
      ),
    ];
  }
}