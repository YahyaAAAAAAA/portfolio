import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:animate_do/animate_do.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/utils/extensions/int_extensions.dart';
import 'package:portfolio_3/utils/platform_utils.dart';
import 'package:portfolio_3/widgets/app/app_divider.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/smooth_list.dart';

class AboutPanel extends StatefulWidget {
  const AboutPanel({super.key});

  @override
  State<AboutPanel> createState() => _AboutPanelState();
}

class _AboutPanelState extends State<AboutPanel> with TickerProviderStateMixin {
  GifController? _gifController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _gifController = GifController(vsync: this);
  }

  @override
  void dispose() {
    _gifController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPanelPaddingMedium),
      child: SmoothList(
        controller: _scrollController,
        child: ListView(
          physics:
              PlatformUtils.isWebMobile
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
          controller: _scrollController,
          children: [
            FadeInLeft(
              duration: const Duration(milliseconds: k500mill),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: null,
                  child: LabelMediumText('About'),
                ),
              ),
            ),

            20.height,

            FadeInUp(
              duration: const Duration(milliseconds: k500mill),
              child: const H1('Turning Ideas Into Interactive Experiences.'),
            ),

            20.height,

            FadeIn(
              duration: const Duration(milliseconds: k500mill),
              child: Align(
                alignment: Alignment.center,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    context.theme.cardColor.withValues(alpha: 0.5),
                    BlendMode.hue,
                  ),
                  child: Gif(
                    controller: _gifController,
                    image: const AssetImage(kAssetDecorationModel1),
                    placeholder:
                        (context) => SizedBox(
                          width: 250,
                          height: 250,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: context.theme.canvasColor,
                            ),
                          ),
                        ),
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
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(milliseconds: 400),
              child: const Align(
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
              duration: const Duration(milliseconds: k500mill),
              child: const BodySmallText('With a focus on app development'),
            ),

            10.height,

            FadeInUp(
              duration: const Duration(milliseconds: k500mill),

              child: const H1(
                'Specialized in crafting seamless, user-friendly experiences.',
              ),
            ),

            100.height,

            FadeInUp(
              duration: const Duration(milliseconds: k500mill),
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        context.theme.cardColor.withValues(alpha: 0.5),
                        BlendMode.hue,
                      ),
                      child: Gif(
                        placeholder:
                            (context) => SizedBox(
                              width: 150,
                              height: 150,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: context.theme.canvasColor,
                                ),
                              ),
                            ),
                        image: const AssetImage(kAssetDecorationModel2),
                        autostart: Autostart.loop,
                        fps: 60,
                        width: 150,
                        height: 150,
                      ),
                    ),
                    const SizedBox(
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
              duration: const Duration(milliseconds: k500mill),
              child: const H3(
                'Creating intuitive interfaces, building efficient architectures, or experimenting with 3D visuals and low-level APIs.',
              ),
            ),

            20.height,

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
