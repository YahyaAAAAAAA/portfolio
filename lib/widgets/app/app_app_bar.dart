import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/mobile_navbar_button.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isMobile;
  final List<bool> panelsEnabled;
  final Function(int) onPanelToggle;

  const AppAppBar({
    super.key,
    required this.isMobile,
    required this.panelsEnabled,
    required this.onPanelToggle,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kAppBarHeight),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kOuterBorderRadius),
          child: AppBar(
            leadingWidth: 160,
            leading: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                spacing: 10,
                children: [
                  Icon(Icons.person_4_rounded),
                  BodyMediumText('Yahya Amarneh'),
                ],
              ),
            ),
            centerTitle: true,
            actions: [const SizedBox(width: 120)],
            title:
                !isMobile
                    ? FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          panelsEnabled.length,
                          (index) =>
                              index == 1
                                  ? const SizedBox.shrink()
                                  : MobileNavbarButton(
                                    index: index,
                                    isSelected: panelsEnabled[index],
                                    label:
                                        index == 0
                                            ? 'About'
                                            : index == 1
                                            ? 'Home'
                                            : index == 2
                                            ? 'Projects'
                                            : index == 3
                                            ? 'Project Display'
                                            : 'Experience',
                                    onPressed: () => onPanelToggle(index),
                                  ),
                        ),
                      ),
                    )
                    : null,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}
