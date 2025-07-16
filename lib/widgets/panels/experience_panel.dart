import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/utils/extensions/int_extensions.dart';
import 'package:portfolio_3/widgets/app/app_divider.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/experience_button.dart';
import 'package:portfolio_3/widgets/horizontal_sliding_widget.dart';
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
                        alpha: _isUniCardHovered ? 0 : 0.3,
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
                          width: kExperienceButtonWidth - 50,
                          height: kExperienceButtonHeight - 50,
                          alpha: _isJYIFCardHovered ? 0 : 0.5,
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
                          alpha: _isCoachYouCardHovered ? 0 : 0.5,
                          width: kExperienceButtonWidth - 50,
                          height: kExperienceButtonHeight - 50,
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
                child: HorizontalSlidingWidget(
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
                child: HorizontalSlidingWidget(
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
                child: BodySmallText('Languages'),
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
