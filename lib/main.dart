import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/utils/extensions/list_extensions.dart';
import 'package:portfolio_3/utils/global_colors.dart';
import 'package:portfolio_3/widgets/animated_collapse.dart';
import 'package:portfolio_3/widgets/cloud.dart';
import 'package:portfolio_3/widgets/distortion_mouse_trail.dart';
import 'package:portfolio_3/widgets/grid_3d_wrapper.dart';
import 'package:portfolio_3/widgets/home_panel.dart';
import 'package:portfolio_3/widgets/grid_mouse_trail.dart';
import 'package:portfolio_3/widgets/noise_wrapper.dart';
import 'package:portfolio_3/widgets/custom_app_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'PPNeueMontreal',
        iconTheme: IconThemeData(color: GColors.white, size: kMediumIconSize),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: GColors.white, size: kMediumIconSize),
          toolbarTextStyle: TextStyle(
            fontFamily: 'PPNeueMontreal',
            fontSize: kSmallFontSize,
            fontWeight: FontWeight.w600,
            color: GColors.white,
          ),
        ),
        scaffoldBackgroundColor: GColors.black,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> panelsEnabled = [true, true, true, true, true];
  double panel3Height = 451;
  double panel4Height = 451;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      panel3Height = context.height() / 2 - 49;
      panel4Height = context.height() / 2 - 49;
      setState(() {});
    });
  }

  void togglePanel(int index) {
    setState(() {
      panelsEnabled[index] = !panelsEnabled[index];
    });
  }

  double getPanelHeight() {
    if (panelsEnabled[3] && !panelsEnabled[4]) {
      return context.height() - 88;
    } else if (!panelsEnabled[3] && panelsEnabled[4]) {
      return context.height() - 88;
    } else if (panelsEnabled[3] && panelsEnabled[4]) {
      return context.height() / 2 - 49;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return NoiseWrapper(
      child: Scaffold(
        appBar: CustomAppBar(
          panelsEnabled: panelsEnabled,
          onPanelToggle: togglePanel,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              //first half
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
                height: context.height(),
                width:
                    panelsEnabled[3] || panelsEnabled[4]
                        ? context.width() / 2 - 15
                        : context.width() - 30,
                child: Column(
                  children: [
                    Expanded(
                      flex: panelsEnabled[0] || panelsEnabled[1] ? 1 : 0,
                      child: Row(
                        children: [
                          //top-left
                          AnimatedCollapse(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOutCubic,
                            collapsed: !panelsEnabled[0],
                            axis: Axis.horizontal,
                            reverseDuration: Duration(milliseconds: 500),
                            child: HomePanel(
                              enabled: true,
                              maxWidth:
                                  (panelsEnabled[3] || panelsEnabled[4]) ||
                                          (context.width() < 960) ||
                                          panelsEnabled.only([0]) ||
                                          panelsEnabled.only([0, 2])
                                      ? context.width() / 4
                                      : 455,
                              height: double.infinity,
                              width: double.infinity,

                              child: Text("Hello"),
                            ),
                          ),

                          //top-right
                          Expanded(
                            child: DistortionTrail(
                              child: HomePanel(
                                enabled: panelsEnabled[1],
                                isExpanded: false,
                                color: GColors.purple,
                                height: double.infinity,
                                //todo : refactor HomePanel widget
                                //add MouseTrails , replace enabled with collapsed
                                //refactor home page, remove unnecessary code, remove magic number
                                //work on theming, more comments, make git
                                child: Grid3DWrapper(
                                  child: Center(
                                    child: Text(
                                      "Yahya Amarneh's\n Website",
                                      style: TextStyle(
                                        fontFamily: 'Acidic',
                                        fontSize: 48,
                                        color: GColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //bottom
                    AnimatedCollapse(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                      collapsed: !panelsEnabled[2],
                      axis: Axis.vertical,
                      reverseDuration: Duration(milliseconds: 500),
                      child: HomePanel(
                        enabled: true,

                        height: 255,
                        width: double.infinity,
                        // width: context.width(),
                        child: Text("Hello"),
                      ),
                    ),
                  ],
                ),
              ),
              //second half
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
                height: context.height(),
                width:
                    panelsEnabled[3] || panelsEnabled[4]
                        ? context.width() / 2 - 15
                        : 0,
                child: Stack(
                  children: [
                    //top
                    Align(
                      alignment: Alignment.topCenter,
                      child: AnimatedCollapse(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.linear,
                        collapsed: !panelsEnabled[3],
                        axis: Axis.vertical,
                        // axisAlignment: -1,
                        reverseDuration: Duration(milliseconds: 500),
                        child: HomePanel(
                          enabled: true,
                          height: getPanelHeight(),
                          width: double.infinity,
                          child: Text('Hello'),
                        ),
                      ),
                    ),
                    //bottom
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedCollapse(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOutCubic,
                        collapsed: !panelsEnabled[4],
                        axis: Axis.vertical,
                        axisAlignment: -1,
                        reverseDuration: Duration(milliseconds: 500),
                        child: HomePanel(
                          enabled: true,
                          isExpanded: false,
                          color: GColors.white,
                          height: getPanelHeight(),
                          width: double.infinity,
                          child: Text('Hello'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
