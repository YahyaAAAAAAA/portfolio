import 'package:flutter/material.dart';
import 'package:portfolio_3/pages/home_page.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/global_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: kFontFamily,
        scaffoldBackgroundColor: GColors.black,
        primaryColor: GColors.darkPurple,
        cardColor: GColors.darkPurple,
        canvasColor: GColors.purple,
        splashColor: GColors.persianIndigo,
        disabledColor: GColors.lightGrey,
        iconTheme: IconThemeData(color: GColors.white, size: kIconSizeMedium),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: GColors.white, size: kIconSizeMedium),
          backgroundColor: GColors.darkPurple,
        ),
        dividerColor: GColors.indigo,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            // foregroundColor: GColors.indigo,
            backgroundColor: GColors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kOuterBorderRadius),
            ),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            backgroundColor: GColors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kOuterBorderRadius),
            ),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: GColors.darkPurple,
          onSurface: GColors.white,
        ),
      ),
      home: HomePage(),
    );
  }
}

  // duration: Duration(milliseconds: 300),
                                    // //size transition
                                    // transitionBuilder:
                                    //     (child, animation) => ScaleTransition(
                                    //       scale: CurvedAnimation(
                                    //         parent: animation,
                                    //         curve: Curves.elasticInOut,
                                    //       ),
                                    //       child: FadeTransition(
                                    //         opacity: animation,
                                    //         child: child,
                                    //       ),
                                    //     ),
                                    // baseChild: ModelViewer(
                                    //   backgroundColor: Colors.transparent,
                                    //   src: 'assets/images/liz.glb',
                                    //   alt: 'A 3D model of an astronaut',
                                    //   ar: true,
                                    //   shadowIntensity: 0.5,
                                    //   shadowSoftness: 0.5,
                                    //   autoRotate: true,
                                    //   disablePan: true,
                                    //   disableZoom: true,
                                    //   environmentImage: 'legacy',
                                    //   disableTap: true,
                                    //   cameraControls: true,
                                    //   cameraOrbit: '-90deg',
                                    //   rotationPerSecond: '700%',
                                    //   autoRotateDelay: 0,
                                    //   interactionPrompt: InteractionPrompt.none,
                                    // ),