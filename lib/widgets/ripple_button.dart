import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/widgets/mouse_trails/ripple_mouse_trail.dart';

class RippleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? rippleColor;
  final double? rippleRadius;
  final bool? centerChild;
  final Widget? child;
  final double? borderWidth;
  final MouseCursor? cursor;

  const RippleButton({
    super.key,
    this.child,
    this.onPressed,
    this.width = 180,
    this.height = 160,
    this.backgroundColor,
    this.borderColor,
    this.rippleColor,
    this.centerChild = true,
    this.rippleRadius = 1.2,
    this.borderWidth = 1,
    this.cursor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kOuterBorderRadius),
            border: Border.all(
              color: borderColor ?? context.theme.dividerColor,
              width: borderWidth ?? 1,
            ),
          ),
          child: RippleMouseTrail(
            cursor: cursor ?? SystemMouseCursors.click,
            rippleColor: rippleColor ?? context.theme.splashColor,
            baseColor: backgroundColor ?? context.theme.cardColor,
            rippleRadius: rippleRadius ?? 1.2,
            child:
                centerChild == true
                    ? Center(child: child ?? const SizedBox.shrink())
                    : child ?? const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
