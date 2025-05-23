import 'package:flutter/material.dart';
import 'package:modisch/shared/widget/overlay/app_overlay.dart';
import 'package:modisch/shared/widget/overlay/overlay_types.dart';

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
    return AppOverlay(
      isVisible: isVisible,
      config: OverlayConfig.menu,
      onTap: onTap,
    );
  }
}