import 'package:flutter/material.dart';

class OverlayController extends ChangeNotifier {
  bool _isVisible = false;
  bool _isAnimating = false;

  bool get isVisible => _isVisible;
  bool get isAnimating => _isAnimating;

  void show() {
    if (!_isVisible) {
      _isVisible = true;
      _handleAnimationState();
      notifyListeners();
    }
  }

  void hide() {
    if (_isVisible) {
      _isVisible = false;
      _handleAnimationState();
      notifyListeners();
    }
  }

  void toggle() {
    _isVisible = !_isVisible;
    _handleAnimationState();
    notifyListeners();
  }

  void _handleAnimationState() {
    _isAnimating = true;
    
    // Mark animation as complete after a short delay
    Future.delayed(const Duration(milliseconds: 350), () {
      _isAnimating = false;
      notifyListeners();
    });
  }
}