import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/global_colors.dart';

ThemeData getAppTheme() {
  return ThemeData(
    fontFamily: kFontFamily,
    scaffoldBackgroundColor: GColors.black,
    primaryColor: GColors.darkPurple,
    cardColor: GColors.darkPurple,
    canvasColor: GColors.purple,
    splashColor: GColors.persianIndigo,
    disabledColor: GColors.lightGrey,
    iconTheme: IconThemeData(color: GColors.white, size: kIconSizeMedium),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: GColors.white, size: kIconSizeMedium),
      backgroundColor: GColors.darkPurple,
    ),
    dividerColor: GColors.indigo,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: GColors.indigo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kOuterBorderRadius),
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: GColors.indigo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kOuterBorderRadius),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide.none,
        iconColor: GColors.white,
        padding: const EdgeInsets.all(kPanelPaddingSmall),
        minimumSize: const Size(30, 30),
        fixedSize: const Size(30, 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kOuterBorderRadius),
        ),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: GColors.darkPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kOuterBorderRadius),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: GColors.darkPurple,
      onSurface: GColors.white,
    ),
  );
}
