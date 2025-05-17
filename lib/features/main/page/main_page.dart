import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gunakan navigationShell langsung sebagai body
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Planner',
          ),
        ],
        onTap: (index) => navigationShell.goBranch(
          index,
          // Opsional: Jika ingin animasi, gunakan ini
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}