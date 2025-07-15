import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  Color _purple = const Color(0xFF45345a); // Default purple

  Color get purple => _purple;

  void updatePurple(Color newColor) {
    _purple = newColor;
    notifyListeners();
  }
}
