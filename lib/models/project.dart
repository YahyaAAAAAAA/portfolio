import 'package:portfolio_3/models/project_segmet.dart';

class Project {
  final String name;
  final String? type;
  final String? platform;
  final String? logo;
  final String? banner;
  final String? description;
  final String? github;
  final String? website;
  final String? video;
  final List<String>? screenshots;
  final List<ProjectSegment>? segments;
  bool isHovered;

  Project({
    required this.name,
    this.platform,
    this.type,
    this.logo,
    this.banner,
    this.description,
    this.github,
    this.website,
    this.video,
    this.screenshots,
    this.segments,
    this.isHovered = false,
  });
}
