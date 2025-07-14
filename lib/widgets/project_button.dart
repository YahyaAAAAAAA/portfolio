import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/mouse_trails/ripple_mouse_trail.dart';

class ProjectButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Widget? child;

  const ProjectButton({
    super.key,
    this.child,
    this.onPressed,
    this.width = 200,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: RippleMouseTrail(
        cursor: SystemMouseCursors.click,
        baseColor: context.theme.cardColor,
        rippleRadius: 1.2,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kOuterBorderRadius),
            border: Border.all(color: context.theme.dividerColor),
          ),
          child:
              child ??
              Padding(
                padding: const EdgeInsets.all(kPanelPaddingMedium),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: context.theme.disabledColor,
                      radius: 30,
                      child: Icon(Icons.android),
                    ),
                    Spacer(),
                    BodyMediumText('Android'),
                    BodySmallText(
                      'Application',
                      color: context.theme.disabledColor,
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
