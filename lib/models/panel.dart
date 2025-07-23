import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/enums/mouse_trail_types.dart';

class Panel {
  final String name;
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
    required this.name,
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

  Panel copyWith({
    String? name,
    bool? enabled,
    bool? isExpanded,
    double? width,
    double? height,
    Color? color,
    MouseTrailType? trail,
    double? maxWidth,
    double? maxHeight,
    double? minWidth,
    double? minHeight,
    Axis? axis,
    Alignment? alignment,
  }) {
    return Panel(
      name: name ?? this.name,
      enabled: enabled ?? this.enabled,
      isExpanded: isExpanded ?? this.isExpanded,
      width: width ?? this.width,
      height: height ?? this.height,
      color: color ?? this.color,
      trail: trail ?? this.trail,
      maxWidth: maxWidth ?? this.maxWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      minWidth: minWidth ?? this.minWidth,
      minHeight: minHeight ?? this.minHeight,
      axis: axis ?? this.axis,
      alignment: alignment ?? this.alignment,
    );
  }
}
