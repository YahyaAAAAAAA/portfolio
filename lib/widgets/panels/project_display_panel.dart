import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_3/models/project.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/utils/extensions/int_extensions.dart';
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
          physics: const NeverScrollableScrollPhysics(),
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
                        CachedNetworkImage(
                          imageUrl: widget.project.logo!,
                          placeholder:
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) => Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: context.theme.canvasColor,
                                ),
                              ),
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
                            child: const Icon(Icons.code_rounded),
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

            H3(widget.project.segments?.first.title ?? ''),

            10.height,

            BodyMediumText(widget.project.segments?.first.description ?? ''),

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
                            onTap:
                                () => context.dialog(
                                  barrierDismissible: true,
                                  pageBuilder:
                                      (context, _, __) => Padding(
                                        padding: const EdgeInsets.all(
                                          kPanelPaddingMedium,
                                        ),
                                        child: Center(
                                          child: InteractiveViewer(
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  widget
                                                      .project
                                                      .screenshots![index],
                                              placeholder:
                                                  (
                                                    context,
                                                    url,
                                                  ) => const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                ),
                            child: CachedNetworkImage(
                              imageUrl: widget.project.screenshots![index],
                              placeholder:
                                  (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                              fit: BoxFit.contain,
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
}
