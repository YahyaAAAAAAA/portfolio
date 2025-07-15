import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:animate_do/animate_do.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/utils/extensions/int_extensions.dart';
import 'package:portfolio_3/utils/theme/theme_notifier.dart';
import 'package:portfolio_3/widgets/app/app_divider.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/smooth_list.dart';
import 'package:provider/provider.dart';

class AboutPanel extends StatefulWidget {
  const AboutPanel({super.key});

  @override
  State<AboutPanel> createState() => _AboutPanelState();
}

class _AboutPanelState extends State<AboutPanel> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  GifController? _gifController;

  @override
  void initState() {
    super.initState();

    _gifController = GifController(vsync: this);
  }

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
                    onPressed: () {
                      context.read<ThemeNotifier>().updatePurple(
                        Colors.red,
                      ); // Change to red
                    },
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
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      context.theme.cardColor,
                      BlendMode.hue,
                    ),
                    child: Gif(
                      controller: _gifController,
                      image: AssetImage(kDecorationModel1),
                      autostart: Autostart.loop,
                      fps: 60,
                      width: 250,
                      height: 250,
                    ),
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

              10.height,

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
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          context.theme.cardColor,
                          BlendMode.hue,
                        ),
                        child: Gif(
                          image: AssetImage(kDecorationModel2),
                          autostart: Autostart.loop,
                          fps: 60,
                          width: 150,
                          height: 150,
                        ),
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
