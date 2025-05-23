import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modisch/core/constants/colors.dart';

class TabButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final bool isActive;
  final VoidCallback onTap;

  const TabButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: 120,
        decoration: BoxDecoration(
          color: isActive ? AppColors.secondary : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? AppColors.secondary : Colors.grey[300]!,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isActive ? 0.1 : 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: 24,
              width: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? AppColors.primary : AppColors.fontActive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}