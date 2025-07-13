import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';

class AppDivider extends StatelessWidget {
  final double thickness;
  final double height;
  final double indent;
  final double endIndent;
  final double? borderRadius;
  final Color? color;

  const AppDivider({
    super.key,
    this.thickness = 10,
    this.height = 10,
    this.indent = 0,
    this.endIndent = 0,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        borderRadius ?? kOuterBorderRadius - 3,
      ),
      child: Divider(
        thickness: thickness,
        height: height,
        indent: indent,
        color: color ?? context.theme.dividerColor,
        endIndent: endIndent,
      ),
    );
  }
}
