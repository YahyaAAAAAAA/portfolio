import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/utils/extensions/int_extensions.dart';
import 'package:portfolio_3/widgets/app/app_divider.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/experience_button.dart';
import 'package:portfolio_3/widgets/horizontal_scroll_behaivor.dart';
import 'package:portfolio_3/widgets/horizontal_sliding_widget.dart';
import 'package:portfolio_3/widgets/mouse_trails/ripple_mouse_trail.dart';
import 'package:portfolio_3/widgets/ripple_button.dart';
import 'package:portfolio_3/widgets/smooth_list.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperiencePanel extends StatefulWidget {
  const ExperiencePanel({super.key});

  @override
  State<ExperiencePanel> createState() => _ExperiencePanelState();
}

class _ExperiencePanelState extends State<ExperiencePanel> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _internshipsScrollController = ScrollController();
  bool _isUniCardHovered = false;
  bool _isJYIFCardHovered = false;
  bool _isCoachYouCardHovered = false;
  bool _isHopeInternationalCardHovered = false;
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
    _internshipsScrollController.dispose();
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
                  child: LabelMediumText('Experience'),
                ),
              ),
            ),

            20.height,

            FadeInLeft(
              duration: const Duration(milliseconds: k500mill),
              child: const H1('Bachelor Degree of Science in Computer Science'),
            ),

            20.height,

            FadeInRight(
              duration: const Duration(milliseconds: k500mill),
              child: SizedBox(
                height: 230,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
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
              duration: const Duration(milliseconds: k500mill),
              child: const BodySmallText('Internships'),
            ),

            10.height,

            FadeInLeft(
              duration: const Duration(milliseconds: k500mill),
              child: const BodyLargeText(
                'In Flutter, Data Analytics, Machine Learning, Full-Stack Development and more.',
              ),
            ),

            20.height,

            FadeInRight(
              duration: const Duration(milliseconds: k500mill),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: kExperienceButtonHeight - 50,
                  child: ScrollConfiguration(
                    behavior: HorizontalScrollBehavior(),
                    child: SmoothList(
                      controller: _internshipsScrollController,
                      child: ListView.separated(
                        controller: _internshipsScrollController,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => 10.width,
                        itemCount: 3,
                        itemBuilder:
                            (context, index) =>
                                [
                                  ExperienceButton(
                                    image: kHopeInternational,
                                    subTitle: '2025',
                                    title: 'The Hope International',
                                    width: kExperienceButtonWidth - 50,
                                    height: kExperienceButtonHeight - 50,
                                    alpha:
                                        _isHopeInternationalCardHovered
                                            ? 0
                                            : 0.5,
                                    onPressed:
                                        () => launchUrl(
                                          Uri.parse(kHopeInternationalUrl),
                                        ),
                                    onEnter:
                                        () => setState(
                                          () =>
                                              _isHopeInternationalCardHovered =
                                                  true,
                                        ),
                                    onExit:
                                        () => setState(
                                          () =>
                                              _isHopeInternationalCardHovered =
                                                  false,
                                        ),
                                  ),

                                  ExperienceButton(
                                    image: kCoachYou,
                                    subTitle: '2025',
                                    title: 'CoachYou',
                                    alpha: _isCoachYouCardHovered ? 0 : 0.5,
                                    width: kExperienceButtonWidth - 50,
                                    height: kExperienceButtonHeight - 50,
                                    onPressed:
                                        () =>
                                            launchUrl(Uri.parse(kCoachYouUrl)),
                                    onEnter:
                                        () => setState(
                                          () => _isCoachYouCardHovered = true,
                                        ),
                                    onExit:
                                        () => setState(
                                          () => _isCoachYouCardHovered = false,
                                        ),
                                  ),

                                  ExperienceButton(
                                    image: kJYIF,
                                    subTitle: '2025',
                                    title: 'JYIF',
                                    width: kExperienceButtonWidth - 50,
                                    height: kExperienceButtonHeight - 50,
                                    alpha: _isJYIFCardHovered ? 0 : 0.5,
                                    onPressed:
                                        () => launchUrl(Uri.parse(kJYIFUrl)),
                                    onEnter:
                                        () => setState(
                                          () => _isJYIFCardHovered = true,
                                        ),
                                    onExit:
                                        () => setState(
                                          () => _isJYIFCardHovered = false,
                                        ),
                                  ),
                                ][index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            60.height,

            FadeInLeft(
              duration: const Duration(milliseconds: k500mill),
              child: const BodySmallText('Technical Skills'),
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
                      .asMap()
                      .entries
                      .map(
                        (entry) => RippleButton(
                          width: kSkillButtonWidth,
                          height: kSkillButtonHeight,
                          backgroundColor:
                              entry.key.isEven
                                  ? context.theme.cardColor
                                  : context.theme.dividerColor,
                          rippleRadius: 1,
                          child: BodyMediumText(entry.value),
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
                      .asMap()
                      .entries
                      .map(
                        (entry) => RippleButton(
                          width: kSkillButtonWidth,
                          height: kSkillButtonHeight,
                          backgroundColor:
                              entry.key.isEven
                                  ? context.theme.cardColor
                                  : context.theme.dividerColor,
                          child: BodyMediumText(entry.value),
                        ),
                      ),
                ],
              ),
            ),

            20.height,

            //languages
            FadeInLeft(
              duration: const Duration(milliseconds: k500mill),
              child: const BodySmallText('Languages'),
            ),

            20.height,

            FadeInLeft(
              duration: const Duration(milliseconds: k500mill),
              child: SizedBox(
                height: kSkillButtonHeight,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
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
                            child: Center(child: BodyMediumText(e)),
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
              duration: const Duration(milliseconds: k500mill),
              child: const AppDivider(),
            ),
          ],
        ),
      ),
    );
  }
}
