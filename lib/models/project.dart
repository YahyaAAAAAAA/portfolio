class Project {
  final String name;
  final String? type;
  final String? platform;
  final String? logo;
  final String? banner;
  final String? description;
  final String? link;
  final List<String>? images;
  bool isHovered;

  Project({
    required this.name,
    this.platform,
    this.type,
    this.logo,
    this.banner,
    this.description,
    this.link,
    this.images,
    this.isHovered = false,
  });
}
