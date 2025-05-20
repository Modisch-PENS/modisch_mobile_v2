import 'package:flutter/material.dart';

class MenuOverlay extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onTap;
  
  const MenuOverlay({
    super.key,
    required this.isVisible,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      // This ensures the widget stays in the tree for the exit animation
      child: IgnorePointer(
        ignoring: !isVisible,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            color: Colors.black54,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}