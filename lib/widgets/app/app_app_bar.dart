import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<bool> panelsEnabled;
  final Function(int) onPanelToggle;

  const AppAppBar({
    super.key,
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
            leadingWidth: 120,
            leading: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                spacing: 10,
                children: [
                  Icon(Icons.person_4_rounded),
                  BodyMediumText('Portfolio'),
                ],
              ),
            ),
            centerTitle: true,
            actions: [const SizedBox(width: 120)],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                panelsEnabled.length,
                (index) => IconButton(
                  onPressed: () => onPanelToggle(index),
                  icon: Icon(
                    size: kIconSizeSmall,
                    panelsEnabled[index] ? Icons.circle : Icons.circle_outlined,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}
