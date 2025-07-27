import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_3/models/project.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/custom_icons.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/utils/extensions/int_extensions.dart';
import 'package:portfolio_3/utils/platform_utils.dart';
import 'package:portfolio_3/widgets/app/app_image.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/project_video_player.dart';
import 'package:portfolio_3/widgets/ripple_button.dart';
import 'package:portfolio_3/widgets/smooth_list.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDisplayPanel extends StatefulWidget {
  final Project project;

  const ProjectDisplayPanel({super.key, required this.project});

  @override
  State<ProjectDisplayPanel> createState() => _ProjectDisplayPanelState();
}

class _ProjectDisplayPanelState extends State<ProjectDisplayPanel> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPanelPaddingMedium),
      child: SmoothList(
        controller: _scrollController,
        child: ListView(
          physics:
              PlatformUtils.isWebMobile
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
          controller: _scrollController,
          children: [
            FadeInLeft(
              duration: const Duration(milliseconds: k500mill),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: null,
                  child: LabelMediumText('Project Display'),
                ),
              ),
            ),

            20.height,

            //name
            FadeInLeft(
              duration: const Duration(milliseconds: k500mill),
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,

                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      spacing: 15,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppImage(
                          imageUrl: widget.project.logo!,
                          width: 50,
                          height: 50,
                        ),
                        H3(widget.project.name),
                      ],
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Row(
                      spacing: 5,
                      children: [
                        if (widget.project.github != null)
                          RippleButton(
                            width: 40,
                            height: 40,
                            onPressed:
                                () => launchUrl(
                                  Uri.parse(widget.project.github!),
                                ),
                            child: const Icon(CustomIcons.github),
                          ),
                        if (widget.project.video != null)
                          RippleButton(
                            width: 40,
                            height: 40,
                            onPressed:
                                () => context.dialog(
                                  pageBuilder:
                                      (context, _, __) =>
                                          ProjectVideoPlayerDialog(
                                            videoUrl: widget.project.video!,
                                          ),
                                ),
                            child: const Icon(Icons.play_arrow_rounded),
                          ),
                        if (widget.project.website != null)
                          RippleButton(
                            width: 40,
                            height: 40,
                            onPressed:
                                () => launchUrl(
                                  Uri.parse(widget.project.website!),
                                ),
                            child: const Icon(Icons.launch_rounded),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            20.height,

            FadeInLeft(
              duration: const Duration(milliseconds: k500mill),
              child: H3(widget.project.segments?.first.title ?? ''),
            ),

            10.height,

            FadeInUp(
              duration: const Duration(milliseconds: k500mill),
              child: BodyMediumText(
                widget.project.segments?.first.description ?? '',
              ),
            ),

            20.height,

            widget.project.screenshots?.isEmpty ?? true
                ? const SizedBox.shrink()
                : CarouselSlider(
                  options: CarouselOptions(
                    height: context.height() * 0.5,
                    viewportFraction: 0.3,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: k500mill,
                    ),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                  ),
                  items: List<Widget>.generate(
                    widget.project.screenshots?.length ?? 0,
                    (index) => Padding(
                      padding: const EdgeInsets.all(kPanelPaddingSmall),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(kOuterBorderRadius),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            //show image in full screen
                            onTap: () => openImagesFullscreen(index),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: context.theme.dividerColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(
                                  kOuterBorderRadius,
                                ),
                              ),
                              child: AppImage(
                                imageUrl: widget.project.screenshots![index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

            20.height,

            for (var segment in widget.project.segments!)
              if (segment.title != 'Introduction')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    H3(segment.title),
                    10.height,
                    BodyMediumText(segment.description),
                    20.height,
                  ],
                ),
          ],
        ),
      ),
    );
  }

  void goLeft(int currentIndex, List<String> screenshots) {
    setState(() => currentIndex = (currentIndex - 1) % screenshots.length);
  }

  void goRight(int currentIndex, List<String> screenshots) {
    setState(() => currentIndex = (currentIndex + 1) % screenshots.length);
  }

  void openImagesFullscreen(int initialIndex) {
    int currentIndex = initialIndex;
    final screenshots = widget.project.screenshots!;
    context.dialog(
      barrierDismissible: true,
      pageBuilder:
          (context, _, __) => StatefulBuilder(
            builder: (context, setState) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: AlertDialog(
                  backgroundColor: Colors.transparent,

                  //close button
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BodyMediumText(
                        'Swipe to navigate ${currentIndex + 1} / ${screenshots.length}',
                      ),
                      RippleButton(
                        width: 30,
                        height: 30,
                        backgroundColor: context.theme.dividerColor,
                        child: const Icon(Icons.close_rounded),
                        onPressed: () => context.pop(),
                      ),
                    ],
                  ),
                  content: Padding(
                    padding: const EdgeInsets.all(kPanelPaddingMedium),
                    child: InteractiveViewer(
                      child: GestureDetector(
                        onHorizontalDragEnd: (details) {
                          const double minSwipeVelocity = 300.0;
                          if (details.velocity.pixelsPerSecond.dx.abs() <
                              minSwipeVelocity) {
                            return;
                          }
                          if (details.velocity.pixelsPerSecond.dx > 0) {
                            setState(
                              () =>
                                  currentIndex =
                                      (currentIndex - 1) % screenshots.length,
                            );
                          } else {
                            setState(
                              () =>
                                  currentIndex =
                                      (currentIndex + 1) % screenshots.length,
                            );
                          }
                        },
                        child: AppImage(
                          imageUrl: screenshots[currentIndex],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
