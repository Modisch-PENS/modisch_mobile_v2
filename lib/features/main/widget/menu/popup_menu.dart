import 'package:flutter/material.dart';
import 'package:modisch/features/main/models/menu_models.dart';
import 'package:modisch/features/main/widget/menu/menu_section_widget.dart';

class PopupMenu extends StatelessWidget {
  final bool isVisible;
  final List<MenuSection> menuSections;
  
  const PopupMenu({
    super.key,
    required this.isVisible,
    required this.menuSections,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 32,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        // IgnorePointer prevents interaction when invisible
        child: IgnorePointer(
          ignoring: !isVisible,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(
              0,
              isVisible ? 0 : 50,
              0,
            ),
            // Keep the widget in the tree for animation
            child: Opacity(
              // This ensures the widget is effectively invisible but still in the tree
              opacity: isVisible ? 1.0 : 0.0,
              child: Center(
                child: Column(
                  children: menuSections
                      .map((section) => MenuSectionWidget(section: section))
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}