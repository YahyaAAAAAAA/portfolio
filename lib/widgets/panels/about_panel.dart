import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:animate_do/animate_do.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/int_extensions.dart';
import 'package:portfolio_3/widgets/app/app_divider.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/smooth_list.dart';

class AboutPanel extends StatefulWidget {
  const AboutPanel({super.key});

  @override
  State<AboutPanel> createState() => _AboutPanelState();
}

class _AboutPanelState extends State<AboutPanel> {
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
            controller: _scrollController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              FadeInLeft(
                duration: Duration(milliseconds: k500mill),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: null,
                    child: LabelMediumText('About'),
                  ),
                ),
              ),

              20.height,

              FadeInUp(
                duration: Duration(milliseconds: k500mill),
                child: H1('Turning Ideas Into Interactive Experiences.'),
              ),

              20.height,

              FadeIn(
                duration: Duration(milliseconds: k500mill),
                child: Align(
                  alignment: Alignment.center,
                  child: Gif(
                    image: AssetImage('assets/images/model2.gif'),
                    autostart: Autostart.loop,
                    width: 250,
                    height: 250,
                  ),
                ),
              ),

              20.height,

              FadeInRight(
                duration: Duration(milliseconds: 1000),
                delay: Duration(milliseconds: 400),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 300,
                    child: BodyMediumText(
                      'A passionate and detail-oriented software developer based in Jordan.',
                    ),
                  ),
                ),
              ),

              100.height,

              FadeInLeft(
                duration: Duration(milliseconds: k500mill),
                child: BodySmallText('With a focus on app development'),
              ),

              20.height,

              FadeInUp(
                duration: Duration(milliseconds: k500mill),

                child: H1(
                  'Specialized in crafting seamless, user-friendly experiences.',
                ),
              ),

              100.height,

              FadeInUp(
                duration: Duration(milliseconds: k500mill),
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Gif(
                        image: AssetImage('assets/images/model4.gif'),
                        autostart: Autostart.loop,
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(
                        width: 200,
                        child: BodyMediumText(
                          'Solving problems, learning new technologies, and bringing ambitious ideas to life',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              20.height,

              FadeInUp(
                duration: Duration(milliseconds: k500mill),
                child: H3(
                  'Creating intuitive interfaces, building efficient architectures, or experimenting with 3D visuals and low-level APIs.',
                ),
              ),

              20.height,

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
