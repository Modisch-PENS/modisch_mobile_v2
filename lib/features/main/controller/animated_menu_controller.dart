// features/main/controllers/animated_menu_controller.dart
import 'package:flutter/material.dart';

class AnimatedMenuController extends ChangeNotifier {
  bool _isVisible = false;
  
  bool get isVisible => _isVisible;
  
  final Duration opacityDuration = const Duration(milliseconds: 250);
  
  void toggle() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
  
  void close() {
    if (_isVisible) {
      _isVisible = false;
      notifyListeners();
    }
  }
}