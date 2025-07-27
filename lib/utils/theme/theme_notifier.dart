import 'package:flutter/material.dart';

class ThemeNotifier {
  static final ValueNotifier<int> _themeIndex = ValueNotifier<int>(0);

  static ValueNotifier<int> get themeNotifier => _themeIndex;

  static void changeTheme(int index) {
    _themeIndex.value = index;
  }

  static int get currentThemeIndex => _themeIndex.value;
}
