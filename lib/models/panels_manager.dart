import 'package:flutter/material.dart';
import 'package:portfolio_3/models/panel.dart';
import 'package:portfolio_3/utils/enums/mouse_trail_types.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/utils/extensions/list_extensions.dart';
import 'package:portfolio_3/utils/global_colors.dart';

class PanelsManager {
  final BuildContext context;

  Panel panel0 = Panel(
    name: 'About',
    enabled: true,
    height: double.infinity,
    width: 455,
    color: GColors.darkPurple,
    trail: MouseTrailType.grid,
    axis: Axis.horizontal,
  );

  Panel panel1 = Panel(
    name: 'Home',
    enabled: true,
    isExpanded: true,
    height: double.infinity,
    color: GColors.purple,
    trail: MouseTrailType.ripple,
    axis: Axis.horizontal,
  );

  Panel panel2 = Panel(
    name: 'Projects',
    enabled: true,
    height: 255,
    width: double.infinity,
    color: GColors.darkPurple,
    trail: MouseTrailType.grid,
    axis: Axis.vertical,
  );

  Panel panel3 = Panel(
    name: 'Project Display',
    enabled: true,
    height: 255,
    width: double.infinity,
    color: GColors.darkPurple,
    trail: MouseTrailType.grid,
    axis: Axis.vertical,
    alignment: Alignment.topCenter,
  );

  Panel panel4 = Panel(
    name: 'Experience',
    enabled: true,
    height: 255,
    width: double.infinity,
    color: GColors.darkPurple,
    trail: MouseTrailType.grid,
    axis: Axis.vertical,
    alignment: Alignment.bottomCenter,
  );

  List<bool> get panelsEnabled => [
    panel0.enabled,
    panel1.enabled,
    panel2.enabled,
    panel3.enabled,
    panel4.enabled,
  ];

  PanelsManager(this.context);

  void init() {
    // Add safety checks for context
    if (!_isContextValid()) return;

    try {
      panel0.color = context.theme.cardColor;
      panel1.color = context.theme.canvasColor;
      panel2.color = context.theme.cardColor;
      panel3.color = context.theme.cardColor;
      panel4.color = context.theme.cardColor;
    } catch (e) {
      //fallback to default colors if context is invalid
      debugPrint('PanelsManager.init() failed: $e');
    }
  }

  //toggle panel
  void togglePanel(BuildContext context, int index) {
    switch (index) {
      case 0:
        panel0.enabled = !panel0.enabled;
        break;
      case 1:
        panel1.enabled = !panel1.enabled;
        break;
      case 2:
        panel2.enabled = !panel2.enabled;
        break;
      case 3:
        panel3.enabled = !panel3.enabled;
        break;
      case 4:
        panel4.enabled = !panel4.enabled;
        break;
    }

    if (_isContextValid()) {
      onToggleCheck(context);
    }
  }

  double getPanelHeight(BuildContext context) {
    if (!_isContextValid()) return 0;

    try {
      final height = context.height();

      if (panel3.enabled && !panel4.enabled) {
        return height - 88;
      } else if (!panel3.enabled && panel4.enabled) {
        return height - 88;
      } else if (panel3.enabled && panel4.enabled) {
        return height / 2 - 49;
      }
      return 0;
    } catch (e) {
      debugPrint('getPanelHeight() failed: $e');
      return 0;
    }
  }

  void onToggleCheck(BuildContext context) {
    if (!_isContextValid()) return;

    try {
      final width = context.width();
      final height = context.height();

      //don't update dimensions if in mobile view
      if (width < 600) return;

      if (panel2.enabled && height <= 355 && width >= 600) {
        panel2.height = 0;
      } else {
        panel2.height = 255;
      }

      if ((panel3.enabled || panel4.enabled) ||
          (width < 960) ||
          panelsEnabled.only([0]) ||
          panelsEnabled.only([0, 2])) {
        panel0.maxWidth = width / 4;
      } else {
        panel0.maxWidth = 455;
      }

      if (panel3.enabled && !panel4.enabled) {
        panel3.height = height - 88;
      } else if (!panel3.enabled && panel4.enabled) {
        panel4.height = height - 88;
      } else if (panel3.enabled && panel4.enabled) {
        panel3.height = height / 2 - 49;
        panel4.height = height / 2 - 49;
      }
    } catch (e) {
      debugPrint('onToggleCheck() failed: $e');
    }
  }

  bool _isContextValid() {
    try {
      return context.mounted;
    } catch (e) {
      return false;
    }
  }
}
