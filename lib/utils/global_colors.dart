import 'package:flutter/material.dart';

class GColors {
  //dark theme colors
  static const Color darkBackground = Color(0xFF201F2A);
  static const Color darkOnSurface = Color(0xFFFFFFFF);
  static const Color darkCanvas = Color(0xFF45345a);
  static const Color darkCard = Color(0xFF060419);
  static const Color darkDivider = Color(0xFF201F2A);
  static const Color darkSplash = Color(0xFF3b0f7c);
  static const Color darkDisabled = Color(0xFFAFAFAF);
  static const Color transparent = Color(0x00000000);

  //light theme colors
  static const Color lightBackground = Color(0xFFf3f3f3);
  static const Color lightOnSurface = Color(0xFF000000);
  static const Color lightDivider = Color(0xFFf3f3f3);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightSplash = Color(0xFF9F75DD);
  static const Color lightDisabled = Color(0xFFAFAFAF);
  static const Color lightCanvas = Color(0xFF45345a);

  static GlobalColorsManager getColors(int themeIndex) {
    switch (themeIndex) {
      case 1:
        return GlobalColorsManager.lightTheme;

      default:
        return GlobalColorsManager.darkTheme;
    }
  }
}

class GlobalColorsManager {
  final Color background;
  final Color onSurface;
  final Color card;
  final Color canvas;
  final Color divider;
  final Color splash;
  final Color disabled;

  const GlobalColorsManager({
    required this.onSurface,
    required this.background,
    required this.card,
    required this.canvas,
    required this.divider,
    required this.splash,
    required this.disabled,
  });

  static const GlobalColorsManager darkTheme = GlobalColorsManager(
    onSurface: GColors.darkOnSurface,
    background: GColors.darkBackground,
    card: GColors.darkCard,
    canvas: GColors.darkCanvas,
    divider: GColors.darkDivider,
    splash: GColors.darkSplash,
    disabled: GColors.darkDisabled,
  );

  static GlobalColorsManager lightTheme = GlobalColorsManager(
    onSurface: GColors.lightOnSurface,
    background: GColors.lightBackground,
    card: GColors.lightCard,
    canvas: GColors.lightCanvas.withValues(alpha: 0.5),
    divider: GColors.lightDivider,
    splash: GColors.lightSplash,
    disabled: GColors.lightDisabled,
  );
}
