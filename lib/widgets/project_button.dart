import 'package:flutter/material.dart';
import 'package:portfolio_3/models/project.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/widgets/app/app_image.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/ripple_button.dart';

class ProjectButton extends StatelessWidget {
  final Project project;
  final VoidCallback? onPressed;
  final VoidCallback? onEnter;
  final VoidCallback? onExit;
  final Color? borderColor;
  final double? borderWidth;

  const ProjectButton({
    super.key,
    required this.project,
    this.onPressed,
    this.onEnter,
    this.onExit,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => onEnter?.call(),
      onExit: (event) => onExit?.call(),
      child: RippleButton(
        borderColor: borderColor,
        borderWidth: borderWidth,
        onPressed: onPressed,
        centerChild: false,
        child: Padding(
          padding: const EdgeInsets.all(kPanelPaddingMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //logo
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    context.theme.cardColor.withValues(
                      alpha: project.isHovered ? 0 : 0.7,
                    ),
                    BlendMode.color,
                  ),
                  child: AppImage(
                    imageUrl: project.logo!,
                    width: 60,
                    height: 60,
                  ),
                ),
              ),

              const Spacer(),
              //name
              BodyMediumText(project.name),
              //platform
              project.type != null
                  ? BodySmallText(
                    project.type!,
                    color: context.theme.disabledColor,
                  )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
