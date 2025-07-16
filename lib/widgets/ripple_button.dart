import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/widgets/mouse_trails/ripple_mouse_trail.dart';

class RippleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Widget? child;

  const RippleButton({
    super.key,
    this.child,
    this.onPressed,
    this.width = 180,
    this.height = 160,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: RippleMouseTrail(
        cursor: SystemMouseCursors.click,
        baseColor: context.theme.cardColor,

        rippleRadius: 1.2,
        child: ClipRRect(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kOuterBorderRadius),
              border: Border.all(color: context.theme.dividerColor),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
