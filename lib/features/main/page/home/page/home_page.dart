// home_page.dart
import 'package:flutter/material.dart';
import 'package:modisch/core/constants/colors.dart';
import 'package:modisch/features/main/page/home/page/model/page/model_page.dart';
import 'package:modisch/features/main/page/home/page/wardrobe/page/wardrobe_page.dart';
import 'package:modisch/features/main/page/home/widget/category/category_chips.dart';
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
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header Section with Profile
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Background Container
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                
                // Profile Card
                Positioned(
                  top: 32,
                  left: 32,
                  right: 32,
                  child: ProfileHeader(
                    userName: "Salma Afifa",
                    clothesCount: 0,
                    modelsCount: 0,
                  ),
                ),
                
                // Tab Selector
                Positioned(
                  top: 160,
                  left: 56,
                  right: 56,
                  child: TabSelector(
                    currentIndex: _currentTabIndex,
                    onTabSelected: (index) {
                      setState(() {
                        _currentTabIndex = index;
                      });
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 120), // Space for overlapping elements
            
            // Category Filter Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: CategoryChips(),
            ),
            
            const SizedBox(height: 20),
            
            // Content Area with IndexedStack for tab content
            Expanded(
              child: IndexedStack(
                index: _currentTabIndex,
                children: const [
                  WardrobePage(),
                  ModelPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}