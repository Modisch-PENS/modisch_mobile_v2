import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modisch/core/router/route_constants.dart';
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
              debugPrint('Navigating to Add Item page');
              context.goNamed(RouteConstants.addItems);
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
            label: 'Create outfit',
            onTap: () {
              context.goNamed(RouteConstants.addOutfitCanvas);
              closeMenu();
            },
          ),
    
        ],
      ),
    ];
  }
}