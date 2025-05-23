import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modisch/core/constants/colors.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:modisch/features/main/constants/navigation_items.dart';

class StylishBottomBarWrapper extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final VoidCallback? onBeforeNavigation;

  const StylishBottomBarWrapper({
    super.key,
    required this.navigationShell,
    this.onBeforeNavigation,
  });

  void _handleNavigation(int index) {
    // Call optional callback before navigation occurs
    if (onBeforeNavigation != null) {
      onBeforeNavigation!();
    }

    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StylishBottomBar(
      items: NavigationItems.bottomBarItems,
      option: AnimatedBarOptions(
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        inkEffect: true,
        inkColor: AppColors.secondary
      ),
      hasNotch: true,
      fabLocation: StylishBarFabLocation.center,
      currentIndex: navigationShell.currentIndex,
      notchStyle: NotchStyle.circle,
      onTap: _handleNavigation,
    );
  }
}
