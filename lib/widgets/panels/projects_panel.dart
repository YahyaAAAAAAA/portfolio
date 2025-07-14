import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/int_extensions.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/project_button.dart';
import 'package:portfolio_3/widgets/smooth_list.dart';

class ProjectsPanel extends StatefulWidget {
  final Widget Function(BuildContext context, int index) itemBuilder;

  const ProjectsPanel({super.key, required this.itemBuilder});

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
                  ProjectButton(
                    width: 30,
                    height: 30,

                    onPressed:
                        () => _scrollController.animateTo(
                          _scrollController.position.pixels - 200,
                          duration: Duration(milliseconds: k500mill),
                          curve: Curves.easeInOut,
                        ),
                    child: Icon(Icons.arrow_back_rounded),
                  ),
                  10.width,
                  ProjectButton(
                    width: 30,
                    height: 30,

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
                ).copyWith(scrollbars: true),
                child: SmoothList(
                  // enableDrag: false,
                  controller: _scrollController,
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: widget.itemBuilder,
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
