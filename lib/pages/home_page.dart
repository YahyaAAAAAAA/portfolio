import 'package:flutter/material.dart';
import 'package:portfolio_3/models/panels_manager.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/widgets/app/app_app_bar.dart';
import 'package:portfolio_3/widgets/panels/about_panel.dart';
import 'package:portfolio_3/widgets/panels/experience_panel.dart';
import 'package:portfolio_3/widgets/panels/logo_panel.dart';
import 'package:portfolio_3/widgets/panels/projects_panel.dart';
import 'package:portfolio_3/widgets/panels/home_panel.dart';
import 'package:portfolio_3/widgets/project_button.dart';
import 'package:portfolio_3/widgets/wrappers/noise_wrapper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PanelsManager panelsManager;
  int projectIndex = 0;

  @override
  void initState() {
    super.initState();
    panelsManager = PanelsManager(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      panelsManager.init();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //i know this is bad, this is specifically when double tapping window title bar
    panelsManager.onToggleCheck(context);

    return NoiseWrapper(
      child: Scaffold(
        appBar: AppAppBar(
          panelsEnabled: panelsManager.panelsEnabled,
          onPanelToggle:
              (index) =>
                  setState(() => panelsManager.togglePanel(context, index)),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: kPanelPaddingMedium,
            right: kPanelPaddingMedium,
            bottom: kPanelPaddingMedium,
            top: kPanelPaddingSmall,
          ),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              //first half
              AnimatedContainer(
                duration: Duration(milliseconds: k500mill),
                curve: Curves.easeInOutCubic,
                height: context.height(),
                width:
                    panelsManager.panel3.enabled || panelsManager.panel4.enabled
                        ? context.width() / 2 - kPanelPaddingMedium
                        : context.width() - kPanelPaddingMedium * 2,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          //top-left
                          HomePanel(
                            panel: panelsManager.panel0,
                            child: AboutPanel(),
                          ),
                          //top-right
                          HomePanel(
                            panel: panelsManager.panel1,
                            child: LogoPanel(),
                          ),
                        ],
                      ),
                    ),
                    //bottom
                    HomePanel(
                      panel: panelsManager.panel2,
                      child: ProjectsPanel(
                        itemBuilder:
                            (context, index) => ProjectButton(
                              width: 180,
                              height: 160,
                              onPressed:
                                  () => setState(() => projectIndex = index),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              //second half
              AnimatedContainer(
                duration: Duration(milliseconds: k500mill),
                curve: Curves.easeInOutCubic,
                height: context.height(),
                width:
                    panelsManager.panel3.enabled || panelsManager.panel4.enabled
                        ? context.width() / 2 - kPanelPaddingMedium
                        : 0,
                child: Stack(
                  children: [
                    //top
                    HomePanel(
                      panel: panelsManager.panel3,
                      child: Text('Projects Display $projectIndex'),
                    ),
                    //bottom
                    HomePanel(
                      panel: panelsManager.panel4,
                      child: ExperiencePanel(),
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
