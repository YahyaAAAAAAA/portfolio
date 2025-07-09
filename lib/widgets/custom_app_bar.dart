import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/global_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<bool> panelsEnabled;
  final Function(int) onPanelToggle;

  const CustomAppBar({
    super.key,
    required this.panelsEnabled,
    required this.onPanelToggle,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kAppBarHeight),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kOuterBorderRadius),
          child: AppBar(
            backgroundColor: GColors.darkPurple,
            leadingWidth: 120,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                spacing: 10,
                children: [Icon(Icons.person_4_rounded), Text('Portfolio')],
              ),
            ),
            centerTitle: true,
            actions: [SizedBox(width: 120)],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                panelsEnabled.length,
                (index) => IconButton(
                  onPressed: () => onPanelToggle(index),
                  icon: Icon(
                    size: kSmallIconSize,
                    panelsEnabled[index] ? Icons.circle : Icons.circle_outlined,
                    color:
                        panelsEnabled[index]
                            ? GColors.white
                            : GColors.lightGray,
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
  Size get preferredSize => Size.fromHeight(kAppBarHeight);
}
