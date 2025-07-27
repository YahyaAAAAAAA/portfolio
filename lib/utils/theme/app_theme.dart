import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/global_colors.dart';

ThemeData getAppTheme(int themeIndex) {
  final colors = GColors.getColors(themeIndex);

  return ThemeData(
    fontFamily: kFontFamily,
    scaffoldBackgroundColor: colors.background,
    // primaryColor: colors.primary,
    cardColor: colors.card,
    canvasColor: colors.canvas,
    splashColor: colors.splash,
    disabledColor: colors.disabled,
    iconTheme: IconThemeData(color: colors.onSurface, size: kIconSizeMedium),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: colors.onSurface, size: kIconSizeMedium),
      backgroundColor: colors.card,
    ),

    dividerColor: colors.divider,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: colors.divider,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kOuterBorderRadius),
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: colors.divider,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kOuterBorderRadius),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide.none,
        iconColor: colors.onSurface,
        padding: const EdgeInsets.all(kPanelPaddingSmall),
        minimumSize: const Size(30, 30),
        fixedSize: const Size(30, 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kOuterBorderRadius),
        ),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: colors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kOuterBorderRadius),
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.all(colors.canvas.withValues(alpha: 0)),
      trackOutlineWidth: const WidgetStatePropertyAll(1),
      trackOutlineColor: WidgetStatePropertyAll(
        colors.divider.withValues(alpha: 0),
      ),
      thumbColor: WidgetStateProperty.all(colors.card),
      thumbIcon: const WidgetStatePropertyAll(Icon(Icons.square_rounded)),
      padding: const EdgeInsets.all(0),
      splashRadius: 0,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: colors.card,
      onSurface: colors.onSurface,
    ),
  );
}
