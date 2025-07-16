import 'package:flutter/material.dart';
import 'package:portfolio_3/models/project.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/widgets/smooth_list.dart';

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
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SmoothList(
          controller: _scrollController,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            children: [
              //banner
              Image.asset(widget.project.banner!, fit: BoxFit.cover),
            ],
          ),
        ),
      ),
    );
  }
}
