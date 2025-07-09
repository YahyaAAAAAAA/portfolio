import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/global_colors.dart';

class HomePanel extends StatelessWidget {
  final bool enabled;
  final bool isExpanded;
  final Widget? child;
  final double? width;
  final double? height;
  final double? maxWidth;
  final double? maxHeight;
  final double? minWidth;
  final double? minHeight;
  final Color? color;

  const HomePanel({
    super.key,
    required this.enabled,
    this.isExpanded = false,
    this.child,
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.color,
    this.minWidth,
    this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    return isExpanded ? buildWidgetExpanded() : buildWidget();
  }

  Widget buildWidgetExpanded() =>
      Visibility(visible: enabled, child: Expanded(child: buildWidget()));

  Widget buildWidget() {
    return Visibility(
      visible: enabled,
      child: Padding(
        padding: EdgeInsets.all(kPanelPadding),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          width: width,
          height: height,
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? double.infinity,
            maxHeight: maxHeight ?? double.infinity,
            minWidth: minWidth ?? 0,
            minHeight: minHeight ?? 0,
          ),
          decoration: BoxDecoration(
            color: color ?? GColors.darkPurple,
            borderRadius: BorderRadius.circular(kOuterBorderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}
