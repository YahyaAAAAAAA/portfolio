import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';

class AppDivider extends StatelessWidget {
  final double thickness;
  final double dividerHeight;
  final double indent;
  final double endIndent;
  final double? borderRadius;
  final Color? color;
  final double? width;
  final double? height;

  const AppDivider({
    super.key,
    this.thickness = 10,
    this.dividerHeight = 10,
    this.indent = 0,
    this.endIndent = 0,
    this.borderRadius,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        borderRadius ?? kOuterBorderRadius - 3,
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: Divider(
          thickness: thickness,
          height: dividerHeight,
          indent: indent,
          color: color ?? context.theme.dividerColor,
          endIndent: endIndent,
        ),
      ),
    );
  }
}
