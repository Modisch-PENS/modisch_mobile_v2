import 'package:flutter/material.dart';

class MenuSection {
  final String title;
  final List<MenuItem> items;

  MenuSection({required this.title, required this.items});
}

class MenuItem {
  final IconData icon;
  final Color iconColor;
  final String label;
  VoidCallback? onTap;

  MenuItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.onTap,
  });
}