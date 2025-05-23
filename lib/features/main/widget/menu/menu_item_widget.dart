import 'package:flutter/material.dart';
import 'package:modisch/features/main/models/menu_models.dart';

class MenuItemWidget extends StatelessWidget {
  final MenuItem item;

  const MenuItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Icon(item.icon, color: item.iconColor, size: 16),
            ),
            const SizedBox(width: 12),
            Text(
              item.label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
