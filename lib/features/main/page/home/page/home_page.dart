// home_page.dart
import 'package:flutter/material.dart';
import 'package:modisch/core/constants/colors.dart';
import 'package:modisch/features/main/page/home/page/model/page/model_page.dart';
import 'package:modisch/features/main/page/home/page/wardrobe/page/wardrobe_page.dart';
import 'package:modisch/features/main/page/home/widget/profile_header.dart';
import 'package:modisch/features/main/page/home/widget/tab/tab_selector.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint("currentTabIndex: $_currentTabIndex");
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                ),

                const Positioned(
                  top: 32,
                  left: 32,
                  right: 32,
                  child: ProfileHeader(userName: "Salma Afifa"),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TabSelector(
                currentIndex: _currentTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    _currentTabIndex = index;
                  });
                },
              ),
            ),

            Expanded(
              child: IndexedStack(
                index: _currentTabIndex,
                children: const [WardrobePage(), ModelPage()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
