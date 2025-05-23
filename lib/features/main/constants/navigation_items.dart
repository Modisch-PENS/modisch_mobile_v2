import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modisch/core/constants/colors.dart';
import 'package:modisch/core/constants/typography.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class NavigationItems {
  static List<BottomBarItem> bottomBarItems = [
    BottomBarItem(
      icon: SvgPicture.asset('assets/icons/navbar/home.svg'),
      selectedIcon: SvgPicture.asset('assets/icons/navbar/home_active.svg'),
      selectedColor: AppColors.fontActive,
      unSelectedColor: AppColors.disabled,
      title: Text('Home', style: AppTypography.navbar),
    ),
    BottomBarItem(
      icon: SvgPicture.asset('assets/icons/navbar/planner.svg'),
      selectedIcon: SvgPicture.asset('assets/icons/navbar/planner_active.svg'),
      selectedColor: AppColors.fontActive,
      unSelectedColor: AppColors.disabled,
      title: Text('Planner', style: AppTypography.navbar),
    ),
  ];
}
