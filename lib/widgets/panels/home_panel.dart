import 'package:flutter/material.dart';
import 'package:portfolio_3/models/panel.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/enums/mouse_trail_types.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/widgets/animated_collapse.dart';
import 'package:portfolio_3/widgets/mouse_trails/distortion_mouse_trail.dart';
import 'package:portfolio_3/widgets/mouse_trails/grid_mouse_trail.dart';
import 'package:portfolio_3/widgets/mouse_trails/ripple_mouse_trail.dart';

class HomePanel extends StatelessWidget {
  final Panel panel;
  final Widget? child;

  const HomePanel({super.key, required this.panel, this.child});

  @override
  Widget build(BuildContext context) {
    return panel.isExpanded!
        ? buildWidgetExpanded(context)
        : buildWidget(context);
  }

  Widget buildWidgetExpanded(BuildContext context) =>
      Expanded(child: buildWidget(context));

  Widget buildWidget(BuildContext context) {
    return Align(
      alignment: panel.alignment ?? Alignment.center,
      child: AnimatedCollapse(
        duration: const Duration(milliseconds: k500mill),
        curve: Curves.easeInOutCubic,
        collapsed: !panel.enabled,
        axis: panel.axis ?? Axis.horizontal,
        reverseDuration: const Duration(milliseconds: k500mill),
        child: Padding(
          padding: const EdgeInsets.all(kPanelPaddingSmall),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: k500mill),
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
              color: panel.color,
              borderRadius: BorderRadius.circular(kOuterBorderRadius),
            ),
            child:
                panel.trail == MouseTrailType.grid
                    ? GridMouseTrail(
                      trailColor: context.theme.canvasColor,
                      child: child ?? const SizedBox.shrink(),
                    )
                    : panel.trail == MouseTrailType.distortion
                    ? DistortionMouseTrail(
                      child: child ?? const SizedBox.shrink(),
                    )
                    : panel.trail == MouseTrailType.ripple
                    ? RippleMouseTrail(child: child ?? const SizedBox.shrink())
                    : child,
          ),
        ),
      ),
    );
  }
}
