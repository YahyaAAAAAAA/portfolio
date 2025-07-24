import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/int_extensions.dart';
import 'package:portfolio_3/utils/platform_utils.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/horizontal_scroll_behaivor.dart';
import 'package:portfolio_3/widgets/ripple_button.dart';
import 'package:portfolio_3/widgets/smooth_list.dart';

class ProjectsPanel extends StatefulWidget {
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final bool isMobile;

  const ProjectsPanel({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.isMobile = false,
  });

  @override
  State<ProjectsPanel> createState() => _ProjectsPanelState();
}

class _ProjectsPanelState extends State<ProjectsPanel> {
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
      //grid view if mobile else list view
      child:
          widget.isMobile
              ? SmoothList(
                controller: _scrollController,
                child: GridView.builder(
                  controller: _scrollController,
                  physics:
                      PlatformUtils.isWebMobile
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: kPanelPaddingMedium,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: widget.itemBuilder,
                  itemCount: widget.itemCount,
                ),
              )
              : ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FadeInLeft(
                        duration: const Duration(milliseconds: k500mill),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: null,
                            child: LabelMediumText('Projects'),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          RippleButton(
                            width: 30,
                            height: 30,

                            onPressed:
                                () => _scrollController.animateTo(
                                  _scrollController.position.pixels - 200,
                                  duration: const Duration(
                                    milliseconds: k500mill,
                                  ),
                                  curve: Curves.easeInOut,
                                ),
                            child: const Icon(Icons.arrow_back_rounded),
                          ),
                          10.width,
                          RippleButton(
                            width: 30,
                            height: 30,
                            onPressed:
                                () => _scrollController.animateTo(
                                  _scrollController.position.pixels + 200,
                                  duration: const Duration(
                                    milliseconds: k500mill,
                                  ),
                                  curve: Curves.easeInOut,
                                ),
                            child: const Icon(Icons.arrow_forward_rounded),
                          ),
                        ],
                      ),
                    ],
                  ),
                  20.height,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 160,
                      child: ScrollConfiguration(
                        behavior: HorizontalScrollBehavior(),
                        child: SmoothList(
                          controller: _scrollController,
                          child: ListView.separated(
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: widget.itemBuilder,
                            separatorBuilder: (context, index) => 10.width,
                            itemCount: widget.itemCount,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
