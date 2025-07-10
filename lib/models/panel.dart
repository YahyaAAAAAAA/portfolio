import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/enums/mouse_trail_types.dart';

class Panel {
  bool enabled;
  bool? isExpanded;
  double? width;
  double? height;
  Color? color;
  MouseTrailType? trail;
  double? maxWidth;
  double? maxHeight;
  double? minWidth;
  double? minHeight;
  Axis? axis;
  Alignment? alignment;

  Panel({
    required this.enabled,
    this.isExpanded = false,
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.minWidth,
    this.minHeight,
    this.axis,
    this.color,
    this.trail,
    this.alignment,
  });
}
