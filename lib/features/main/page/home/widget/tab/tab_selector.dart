import 'package:flutter/material.dart';
import 'package:modisch/core/constants/spacing.dart';
import 'package:modisch/features/main/page/home/widget/tab/tab_button.dart';

class TabSelector extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const TabSelector({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TabButton(
            label: 'Wardrobe',
            iconPath:
                'assets/icons/home/wardrobe${currentIndex == 0 ? '_active' : ''}.png',
            isActive: currentIndex == 0,
            onTap: () => onTabSelected(0),
          ),

          horizontalSpace(16),
          TabButton(
            label: 'Model',
            iconPath:
                'assets/icons/home/model${currentIndex == 1 ? '_active' : ''}.png',
            isActive: currentIndex == 1,
            onTap: () => onTabSelected(1),
          ),
        ],
      ),
    );
  }
}
