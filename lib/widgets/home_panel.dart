import 'package:flutter/material.dart';
import 'package:portfolio_3/models/panel.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/enums/mouse_trail_types.dart';
import 'package:portfolio_3/utils/global_colors.dart';
import 'package:portfolio_3/widgets/animated_collapse.dart';
import 'package:portfolio_3/widgets/distortion_mouse_trail.dart';
import 'package:portfolio_3/widgets/grid_mouse_trail.dart';

class HomePanel extends StatelessWidget {
  final Panel panel;
  final Widget? child;

  const HomePanel({super.key, required this.panel, this.child});

  @override
  Widget build(BuildContext context) {
    return panel.isExpanded! ? buildWidgetExpanded() : buildWidget();
  }

  Widget buildWidgetExpanded() => Expanded(child: buildWidget());

  Widget buildWidget() {
    return Align(
      alignment: panel.alignment ?? Alignment.center,
      child: AnimatedCollapse(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        collapsed: !panel.enabled,
        axis: panel.axis ?? Axis.horizontal,
        reverseDuration: Duration(milliseconds: 500),
        child: Padding(
          padding: EdgeInsets.all(kPanelPadding),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            width: panel.width,
            height: panel.height,
            constraints: BoxConstraints(
              maxWidth: panel.maxWidth ?? double.infinity,
              maxHeight: panel.maxHeight ?? double.infinity,
              minWidth: panel.minWidth ?? 0,
              minHeight: panel.minHeight ?? 0,
            ),
            decoration: BoxDecoration(
              color: panel.color ?? GColors.darkPurple,
              borderRadius: BorderRadius.circular(kOuterBorderRadius),
            ),
            child:
                panel.trail == MouseTrailType.grid
                    ? GridMouseTrail(child: child ?? SizedBox.shrink())
                    : panel.trail == MouseTrailType.distortion
                    ? DistortionMouseTrail(child: child ?? SizedBox.shrink())
                    : child,
          ),
        ),
      ),
    );
  }
}
