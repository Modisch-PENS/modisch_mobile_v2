import 'package:flutter/material.dart';

enum OverlayType {
  menu,
  dialog,
  loading,
  custom,
}

class OverlayConfig {
  final Color backgroundColor;
  final Duration animationDuration;
  final bool dismissOnTap;
  final bool ignorePointerWhenHidden;
  final Curve animationCurve;

  const OverlayConfig({
    this.backgroundColor = Colors.black54,
    this.animationDuration = const Duration(milliseconds: 200),
    this.dismissOnTap = true,
    this.ignorePointerWhenHidden = true,
    this.animationCurve = Curves.easeOut,
  });

  static const OverlayConfig menu = OverlayConfig(
    backgroundColor: Colors.black54,
    animationDuration: Duration(milliseconds: 200),
  );

  static const OverlayConfig dialog = OverlayConfig(
    backgroundColor: Colors.black87,
    animationDuration: Duration(milliseconds: 300),
  );

  static const OverlayConfig loading = OverlayConfig(
    backgroundColor: Colors.black26,
    animationDuration: Duration(milliseconds: 150),
    dismissOnTap: false,
  );
}