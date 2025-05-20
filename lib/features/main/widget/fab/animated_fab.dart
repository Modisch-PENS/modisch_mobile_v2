import 'package:flutter/material.dart';

class AnimatedFAB extends StatelessWidget {
  final bool isMenuVisible;
  final VoidCallback onPressed;
  
  const AnimatedFAB({
    super.key,
    required this.isMenuVisible,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: isMenuVisible ? 0.240 : 0,
      duration: const Duration(milliseconds: 250),
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: onPressed,
        child: Icon(isMenuVisible ? Icons.close : Icons.add, size: 28),
      ),
    );
  }
}