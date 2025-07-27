import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/theme/theme_notifier.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/ripple_button.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: ThemeNotifier.themeNotifier,
      builder: (context, currentThemeIndex, child) {
        final isLightTheme = currentThemeIndex == 1;

        return RippleButton(
          height: 30,
          width: 70,
          onPressed: () => ThemeNotifier.changeTheme(isLightTheme ? 0 : 1),
          child: Padding(
            padding:
                isLightTheme
                    ? const EdgeInsets.only(left: 6)
                    : const EdgeInsets.only(right: 6),
            child: Stack(
              children: [
                Align(
                  alignment:
                      isLightTheme
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: LabelSmallText(isLightTheme ? 'Light' : 'Dark'),
                  ),
                ),
                Align(
                  alignment:
                      isLightTheme
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Switch(
                    value: isLightTheme,
                    thumbIcon: WidgetStatePropertyAll(
                      Icon(
                        isLightTheme
                            ? Icons.light_mode_rounded
                            : Icons.dark_mode_rounded,
                      ),
                    ),
                    onChanged:
                        (bool value) =>
                            ThemeNotifier.changeTheme(value ? 1 : 0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
