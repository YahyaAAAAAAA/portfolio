import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/widgets/app/app_divider.dart';
import 'package:portfolio_3/widgets/app/app_image.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/mouse_trails/ripple_mouse_trail.dart';

class ExperienceButton extends StatelessWidget {
  final String image;
  final String imageHash;
  final String subTitle;
  final String title;
  final double alpha;
  final VoidCallback? onPressed;
  final VoidCallback? onEnter;
  final VoidCallback? onExit;
  final double? width;
  final double? height;

  const ExperienceButton({
    super.key,
    required this.image,
    required this.imageHash,
    required this.subTitle,
    required this.title,
    required this.alpha,
    this.onPressed,
    this.onEnter,
    this.onExit,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => onEnter?.call(),
      onExit: (event) => onExit?.call(),
      cursor: SystemMouseCursors.click,
      child: RippleMouseTrail(
        baseColor: context.theme.cardColor,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              border: Border.all(color: context.theme.dividerColor),
              borderRadius: BorderRadius.circular(kOuterBorderRadius),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kOuterBorderRadius),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ColoredBox(
                    color: context.theme.dividerColor,
                    //black-white filter
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        context.theme.dividerColor.withValues(alpha: alpha),
                        BlendMode.color,
                      ),
                      child: AppImage.hash(
                        imageUrl: image,
                        imageHash: imageHash,
                        fit: BoxFit.cover,
                        height: height! / 1.4,
                      ),
                    ),
                  ),

                  const AppDivider(thickness: 1, dividerHeight: 1),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: kPanelPaddingSmall,
                      top: kPanelPaddingSmall,
                    ),
                    child: BodySmallText(
                      subTitle,
                      color: context.theme.disabledColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: kPanelPaddingSmall,
                      right: kPanelPaddingSmall,
                    ),
                    child: TitleLargeText(title),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
