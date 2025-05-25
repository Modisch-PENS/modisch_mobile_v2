import 'package:flutter/material.dart';
import 'package:modisch/core/constants/spacing.dart';
import 'package:modisch/features/main/widget/menu/menu_item_widget.dart';
import 'package:modisch/features/main/models/menu_models.dart';

class MenuSectionWidget extends StatelessWidget {
  final MenuSection section;
  
  const MenuSectionWidget({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            verticalSpace(10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  section.title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            ...section.items.map((item) => MenuItemWidget(item: item)),
            verticalSpace(10),
          ],
        ),
      ),
    );
  }
}