import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/utils/extensions/int_extensions.dart';
import 'package:portfolio_3/widgets/app/app_divider.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/experience_button.dart';
import 'package:portfolio_3/widgets/mouse_trails/ripple_mouse_trail.dart';
import 'package:portfolio_3/widgets/smooth_list.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperiencePanel extends StatefulWidget {
  const ExperiencePanel({super.key});

  @override
  State<ExperiencePanel> createState() => _ExperiencePanelState();
}

class _ExperiencePanelState extends State<ExperiencePanel> {
  final ScrollController _scrollController = ScrollController();
  bool _isUniCardHovered = false;
  bool _isJYIFCardHovered = false;
  bool _isCoachYouCardHovered = false;
  final List<String> _technicalSkills = [
    'Flutter',
    'Dart',
    'Firebase',
    'Kotlin',
    'Android',
    'BLoC',
    'Node.js',
    'JavaScript',
    'HTML',
    'CSS',
    'WebSockets',
    'FFI',
    'C#',
    'WPF',
    'Windows',
    'Blender',
    'UI/UX',
    'REST',
    'Stripe',
    'Git',
  ];

  final List<String> _languages = ['Arabic (Native)', 'English (Fluent)'];

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
              FadeInLeft(
                duration: Duration(milliseconds: k500mill),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: null,
                    child: LabelMediumText('Experience'),
                  ),
                ),
              ),

              20.height,

              FadeInLeft(
                duration: Duration(milliseconds: k500mill),
                child: BodySmallText('Education'),
              ),

              10.height,

              FadeInLeft(
                duration: Duration(milliseconds: k500mill),
                child: H1('Bachelor Degree of Science in Computer Science'),
              ),

              20.height,

              FadeInRightBig(
                duration: Duration(milliseconds: k500mill),
                child: SizedBox(
                  height: 230,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      ExperienceButton(
                        image: kUniImage,
                        subTitle: '2021-2025',
                        title: 'Hashemite University',
                        alpha: _isUniCardHovered ? 0 : 0.8,
                        width: kExperienceButtonWidth,
                        height: kExperienceButtonHeight,
                        onPressed: () => launchUrl(Uri.parse(kUniUrl)),
                        onEnter: () => setState(() => _isUniCardHovered = true),
                        onExit: () => setState(() => _isUniCardHovered = false),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: kPanelPaddingMedium,
                        children: List.generate(
                          7,
                          (index) =>
                              AppDivider(width: context.width(), thickness: 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              60.height,

              FadeInLeft(
                duration: Duration(milliseconds: k500mill),
                child: BodySmallText('Internships'),
              ),

              10.height,

              FadeInLeft(
                duration: Duration(milliseconds: k500mill),
                child: BodyLargeText(
                  'In Data Analytics, Machine Learning, Full-Stack Development and more.',
                ),
              ),

              20.height,

              FadeInRightBig(
                duration: Duration(milliseconds: k500mill),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: kPanelPaddingMedium,
                      children: [
                        ExperienceButton(
                          image: kJYIF,
                          subTitle: '2025',
                          title: 'YJIF',
                          width: kExperienceButtonWidth,
                          height: kExperienceButtonHeight,
                          alpha: _isJYIFCardHovered ? 0 : 0.8,
                          onPressed: () => launchUrl(Uri.parse(kUniUrl)),
                          onEnter:
                              () => setState(() => _isJYIFCardHovered = true),
                          onExit:
                              () => setState(() => _isJYIFCardHovered = false),
                        ),

                        ExperienceButton(
                          image: kCoachYou,
                          subTitle: '2025',
                          title: 'CoachYou',
                          alpha: _isCoachYouCardHovered ? 0 : 0.8,
                          width: kExperienceButtonWidth,
                          height: kExperienceButtonHeight,
                          onPressed: () => launchUrl(Uri.parse(kUniUrl)),
                          onEnter:
                              () =>
                                  setState(() => _isCoachYouCardHovered = true),
                          onExit:
                              () => setState(
                                () => _isCoachYouCardHovered = false,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              60.height,

              FadeInLeft(
                duration: Duration(milliseconds: k500mill),
                child: BodySmallText('Technical Skills'),
              ),

              10.height,

              //first half of technical skills list
              SizedBox(
                height: kSkillButtonHeight,
                child: HorizontalSlidingWidgetSimple(
                  duration: Duration(seconds: (kSillButtonSpacing + 5).toInt()),
                  spacing: kSillButtonSpacing,
                  //technical skills
                  children: [
                    ..._technicalSkills
                        .sublist(0, (_technicalSkills.length / 2).ceil())
                        .map(
                          (skill) => Container(
                            width: kSkillButtonWidth,
                            height: kSkillButtonHeight,
                            decoration: BoxDecoration(
                              color: context.theme.dividerColor,
                              borderRadius: BorderRadius.circular(
                                kOuterBorderRadius,
                              ),
                            ),
                            child: RippleMouseTrail(
                              baseColor: context.theme.dividerColor,
                              child: Center(child: BodyMediumText(skill)),
                            ),
                          ),
                        ),
                  ],
                ),
              ),

              20.height,

              //second half of technical skills list
              SizedBox(
                height: kSkillButtonHeight,
                child: HorizontalSlidingWidgetSimple(
                  duration: Duration(seconds: kSillButtonSpacing.toInt()),
                  spacing: kSillButtonSpacing,
                  children: [
                    ..._technicalSkills
                        .sublist(
                          (_technicalSkills.length / 2).ceil(),
                          _technicalSkills.length,
                        )
                        .map(
                          (skill) => Container(
                            width: kSkillButtonWidth,
                            height: kSkillButtonHeight,
                            decoration: BoxDecoration(
                              color: context.theme.dividerColor,
                              borderRadius: BorderRadius.circular(
                                kOuterBorderRadius,
                              ),
                            ),
                            child: RippleMouseTrail(
                              baseColor: context.theme.dividerColor,
                              child: Center(child: BodyMediumText(skill)),
                            ),
                          ),
                        ),
                  ],
                ),
              ),

              20.height,
              //languages
              FadeInLeft(
                duration: Duration(milliseconds: k500mill),
                child: BodyMediumText('Languages'),
              ),

              20.height,

              FadeInLeft(
                duration: Duration(milliseconds: k500mill),
                child: SizedBox(
                  height: kSkillButtonHeight,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      ..._languages.map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kPanelPaddingMedium,
                          ),
                          child: Container(
                            width: kSkillButtonWidth,
                            height: kSkillButtonHeight,
                            decoration: BoxDecoration(
                              color: context.theme.dividerColor,
                              borderRadius: BorderRadius.circular(
                                kOuterBorderRadius,
                              ),
                            ),

                            child: RippleMouseTrail(
                              child: Center(child: BodyLargeText(e)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              40.height,

              FadeInUp(
                duration: Duration(milliseconds: k500mill),
                child: AppDivider(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalSlidingWidget extends StatefulWidget {
  final List<Widget> children;
  final Duration duration;
  final double spacing;
  final double itemWidth;

  const HorizontalSlidingWidget({
    super.key,
    required this.children,
    this.duration = const Duration(seconds: 10),
    this.spacing = 20.0,
    this.itemWidth = 200.0,
  });

  @override
  State<HorizontalSlidingWidget> createState() =>
      _HorizontalSlidingWidgetState();
}

class _HorizontalSlidingWidgetState extends State<HorizontalSlidingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    // Start the animation and repeat it
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: SlidingPainter(
              children: widget.children,
              progress: _animation.value,
              spacing: widget.spacing,
              itemWidth: widget.itemWidth,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class SlidingPainter extends CustomPainter {
  final List<Widget> children;
  final double progress;
  final double spacing;
  final double itemWidth;

  SlidingPainter({
    required this.children,
    required this.progress,
    required this.spacing,
    required this.itemWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (children.isEmpty) return;

    final totalItemWidth = itemWidth + spacing;
    final totalWidth = children.length * totalItemWidth;

    // Calculate the offset based on progress
    final offset = -progress * totalWidth;

    for (int i = 0; i < children.length; i++) {
      final itemOffset = offset + (i * totalItemWidth);

      // Draw the item if it's visible on screen
      if (itemOffset + itemWidth >= 0 && itemOffset <= size.width) {
        canvas.save();
        canvas.translate(itemOffset, 0);

        // Here you would need to render the widget
        // This is a simplified approach - in practice you'd need to
        // use a RenderObjectWidget or convert widgets to CustomPaint

        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Flexible implementation using Stack and Positioned widgets
class HorizontalSlidingWidgetSimple extends StatefulWidget {
  final List<Widget> children;
  final Duration duration;
  final double spacing;
  final double itemWidth;

  const HorizontalSlidingWidgetSimple({
    super.key,
    required this.children,
    this.duration = const Duration(seconds: 10),
    this.spacing = 20.0,
    this.itemWidth = 200.0,
  });

  @override
  State<HorizontalSlidingWidgetSimple> createState() =>
      _HorizontalSlidingWidgetSimpleState();
}

class _HorizontalSlidingWidgetSimpleState
    extends State<HorizontalSlidingWidgetSimple>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(children: _buildPositionedChildren());
        },
      ),
    );
  }

  List<Widget> _buildPositionedChildren() {
    List<Widget> positioned = [];
    final totalItemWidth = widget.itemWidth + widget.spacing;
    final totalWidth = widget.children.length * totalItemWidth;

    // Create multiple cycles for infinite scrolling
    for (int cycle = 0; cycle < 3; cycle++) {
      for (int i = 0; i < widget.children.length; i++) {
        final basePosition = (cycle * totalWidth) + (i * totalItemWidth);
        final currentPosition = basePosition - (_animation.value * totalWidth);

        positioned.add(
          Positioned(
            left: currentPosition,
            top: 0,
            child: SizedBox(width: widget.itemWidth, child: widget.children[i]),
          ),
        );
      }
    }

    return positioned;
  }
}
