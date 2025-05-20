import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class NavigationItems {
  static List<BottomBarItem> bottomBarItems = [
    BottomBarItem(
      icon: const Icon(Icons.house_outlined),
      selectedIcon: const Icon(Icons.house_rounded),
      selectedColor: Colors.red,
      unSelectedColor: Colors.grey,
      title: const Text('Home'),
    ),
    BottomBarItem(
      icon: const Icon(Icons.star_border_rounded),
      selectedIcon: const Icon(Icons.star_rounded),
      selectedColor: Colors.red,
      title: const Text('Star'),
    ),
  ];
}