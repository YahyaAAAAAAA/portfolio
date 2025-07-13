import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/utils/extensions/int_extensions.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/ripple_hover_button.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class ProjectsPanel extends StatefulWidget {
  const ProjectsPanel({super.key});

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
      padding: EdgeInsets.all(kPanelPaddingMedium),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FadeInLeft(
                duration: Duration(milliseconds: k500mill),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: null,
                    child: LabelMediumText('Projects'),
                  ),
                ),
              ),
              Row(
                children: [
                  RippleHoverButton(
                    width: 30,
                    height: 30,
                    rippleRadius: 1,
                    baseColor: context.theme.dividerColor,
                    onPressed:
                        () => _scrollController.animateTo(
                          _scrollController.position.pixels - 200,
                          duration: Duration(milliseconds: k500mill),
                          curve: Curves.easeInOut,
                        ),
                    child: Icon(Icons.arrow_back_rounded),
                  ),
                  10.width,
                  RippleHoverButton(
                    width: 30,
                    height: 30,
                    rippleRadius: 1,
                    baseColor: context.theme.dividerColor,
                    onPressed:
                        () => _scrollController.animateTo(
                          _scrollController.position.pixels + 200,
                          duration: Duration(milliseconds: k500mill),
                          curve: Curves.easeInOut,
                        ),
                    child: Icon(Icons.arrow_forward_rounded),
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
                behavior: ScrollConfiguration.of(
                  context,
                ).copyWith(scrollbars: false),
                child: WebSmoothScroll(
                  controller: _scrollController,
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ProjectButton(),
                    separatorBuilder: (context, index) => 10.width,
                    itemCount: 10,
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

class ProjectButton extends StatelessWidget {
  const ProjectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return RippleHoverButton(
      width: 180,
      height: 160,
      baseColor: context.theme.cardColor,
      rippleRadius: 1,
      child: Padding(
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
            BodySmallText('Application', color: context.theme.disabledColor),
          ],
        ),
      ),
    );
  }
}
