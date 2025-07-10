import 'package:flutter/material.dart';
import 'package:portfolio_3/models/panels_manager.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/utils/global_colors.dart';
import 'package:portfolio_3/widgets/grid_3d_wrapper.dart';
import 'package:portfolio_3/widgets/home_panel.dart';
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
  final PanelsManager panelsManager = PanelsManager();

  @override
  Widget build(BuildContext context) {
    //i know this is bad, this is specifically when double tapping window title bar
    panelsManager.onToggleCheck(context);

    return NoiseWrapper(
      child: Scaffold(
        appBar: CustomAppBar(
          panelsEnabled: panelsManager.panelsEnabled,
          onPanelToggle:
              (index) =>
                  setState(() => panelsManager.togglePanel(context, index)),
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
                    panelsManager.panel3.enabled || panelsManager.panel4.enabled
                        ? context.width() / 2 - 15
                        : context.width() - 30,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          //top-left
                          HomePanel(
                            panel: panelsManager.panel0,
                            child: Text("Hello"),
                          ),

                          //top-right
                          HomePanel(
                            panel: panelsManager.panel1,
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
                        ],
                      ),
                    ),
                    //bottom
                    HomePanel(
                      panel: panelsManager.panel2,
                      child: Text("Hello"),
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
                    panelsManager.panel3.enabled || panelsManager.panel4.enabled
                        ? context.width() / 2 - 15
                        : 0,
                child: Stack(
                  children: [
                    //top
                    HomePanel(
                      panel: panelsManager.panel3,
                      child: Text('Hello'),
                    ),
                    //bottom
                    HomePanel(
                      panel: panelsManager.panel4,
                      child: Text('Hello'),
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
