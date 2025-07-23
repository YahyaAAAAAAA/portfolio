import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';

class MobileNavbarButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final int index;
  final String label;
  final bool isSelected;

  const MobileNavbarButton({
    super.key,
    this.onPressed,
    required this.index,
    required this.isSelected,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        hoverColor: context.theme.cardColor,
        backgroundColor: context.theme.cardColor,
        highlightColor: context.theme.cardColor,
      ),
      icon: FittedBox(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 5,
          children: [
            isSelected
                ? const Icon(Icons.circle, size: kIconSizeSmall)
                : const Icon(Icons.circle_outlined, size: kIconSizeSmall),
            LabelMediumText(label),
          ],
        ),
      ),
    );
  }
}
