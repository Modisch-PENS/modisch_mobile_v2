import 'package:flutter/material.dart';
import 'overlay_types.dart';

class AppOverlay extends StatelessWidget {
  final bool isVisible;
  final VoidCallback? onTap;
  final OverlayConfig config;
  final Widget? child;

  const AppOverlay({
    super.key,
    required this.isVisible,
    this.onTap,
    this.config = OverlayConfig.menu,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: config.animationDuration,
      curve: config.animationCurve,
      child: IgnorePointer(
        ignoring: config.ignorePointerWhenHidden && !isVisible,
        child: GestureDetector(
          onTap: config.dismissOnTap ? onTap : null,
          child: Container(
            color: config.backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: child,
          ),
        ),
      ),
    );
  }
}