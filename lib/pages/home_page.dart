import 'package:flutter/material.dart';
import 'package:portfolio_3/models/panels_manager.dart';
import 'package:portfolio_3/models/projects_manager.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/widgets/app/app_app_bar.dart';
import 'package:portfolio_3/widgets/mobile_navbar_button.dart';
import 'package:portfolio_3/widgets/panels/about_panel.dart';
import 'package:portfolio_3/widgets/panels/experience_panel.dart';
import 'package:portfolio_3/widgets/panels/logo_panel.dart';
import 'package:portfolio_3/widgets/panels/project_display_panel.dart';
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
  int mobileTabIndex = 0;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        panelsManager = PanelsManager(context);
        panelsManager.init();
        _isInitialized = true;
        if (mounted) setState(() {});
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //initialize here if not already done
    if (!_isInitialized) {
      panelsManager = PanelsManager(context);
      panelsManager.init();
      _isInitialized = true;
    }
  }

  bool get isMobileView => context.width() < kMobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    //don't build if not initialized
    if (!_isInitialized) {
      return const NoiseWrapper(
        child: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    //only call for desktop view and if mounted
    if (!isMobileView && mounted) {
      panelsManager.onToggleCheck(context);
    }

    return NoiseWrapper(
      child: SafeArea(
        child: Scaffold(
          appBar: AppAppBar(
            isMobile: isMobileView,
            panelsEnabled: panelsManager.panelsEnabled,
            onPanelToggle: (index) {
              if (mounted) {
                setState(() => panelsManager.togglePanel(context, index));
              }
            },
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: kPanelPaddingMedium,
              right: kPanelPaddingMedium,
              bottom: kPanelPaddingMedium,
              top: kPanelPaddingSmall,
            ),
            child: isMobileView ? _buildMobileLayout() : _buildDesktopLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    final List<Widget> panels = [
      HomePanel(
        panel: panelsManager.panel0.copyWith(
          width: context.width(),
          height: context.height(),
          maxWidth: context.width(),
          axis: Axis.vertical,
          color: context.theme.cardColor,
          enabled: true,
        ),
        child: const AboutPanel(),
      ),
      HomePanel(
        panel: panelsManager.panel1.copyWith(
          width: context.width(),
          height: context.height(),
          axis: Axis.vertical,
          isExpanded: false,
          color: context.theme.canvasColor,
          enabled: true,
        ),
        child: const LogoPanel(),
      ),
      HomePanel(
        panel: panelsManager.panel2.copyWith(
          width: context.width(),
          height: context.height(),
          color: context.theme.cardColor,
          enabled: true,
        ),
        child: ProjectsPanel(
          itemCount: ProjectsManager.projects.length,
          isMobile: isMobileView,
          itemBuilder:
              (context, index) => FittedBox(
                child: ProjectButton(
                  borderColor:
                      projectIndex == index
                          ? context.theme.canvasColor
                          : context.theme.dividerColor,
                  borderWidth: projectIndex == index ? 1.5 : 1,
                  project: ProjectsManager.projects[index],
                  onEnter: () {
                    if (mounted) {
                      setState(
                        () => ProjectsManager.projects[index].isHovered = true,
                      );
                    }
                  },
                  onExit: () {
                    if (mounted) {
                      setState(
                        () => ProjectsManager.projects[index].isHovered = false,
                      );
                    }
                  },
                  onPressed: () {
                    if (mounted) {
                      if (isMobileView) {
                        mobileTabIndex = 3;
                      }
                      setState(() => projectIndex = index);
                    }
                  },
                ),
              ),
        ),
      ),
      HomePanel(
        panel: panelsManager.panel3.copyWith(
          width: context.width(),
          height: context.height(),
          color: context.theme.cardColor,
          enabled: true,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: k500mill),
          transitionBuilder:
              (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
          child: ProjectDisplayPanel(
            key: ValueKey(ProjectsManager.projects[projectIndex].name),
            project: ProjectsManager.projects[projectIndex],
          ),
        ),
      ),
      HomePanel(
        panel: panelsManager.panel4.copyWith(
          width: context.width(),
          height: context.height(),
          color: context.theme.cardColor,
          enabled: true,
        ),
        child: const ExperiencePanel(),
      ),
    ];

    return Scaffold(
      body: panels[mobileTabIndex],
      bottomNavigationBar: SizedBox(
        height: kAppBarHeight,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(kOuterBorderRadius),
            child: NavigationBar(
              backgroundColor: context.theme.cardColor,
              selectedIndex: mobileTabIndex,

              onDestinationSelected: (index) {
                setState(() {
                  mobileTabIndex = index;
                });
              },
              destinations: [
                MobileNavbarButton(
                  index: 0,
                  isSelected: mobileTabIndex == 0,
                  label: 'About',
                  onPressed: () => setState(() => mobileTabIndex = 0),
                ),
                MobileNavbarButton(
                  index: 1,
                  isSelected: mobileTabIndex == 1,
                  label: 'Home',
                  onPressed: () => setState(() => mobileTabIndex = 1),
                ),
                MobileNavbarButton(
                  index: 2,
                  isSelected: mobileTabIndex == 2,
                  label: 'Projects',
                  onPressed: () => setState(() => mobileTabIndex = 2),
                ),
                MobileNavbarButton(
                  index: 3,
                  isSelected: mobileTabIndex == 3,
                  label: 'Display',
                  onPressed: () => setState(() => mobileTabIndex = 3),
                ),
                MobileNavbarButton(
                  index: 4,
                  isSelected: mobileTabIndex == 4,
                  label: 'Experience',
                  onPressed: () => setState(() => mobileTabIndex = 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: [
        //first half
        AnimatedContainer(
          duration: const Duration(milliseconds: k500mill),
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
                      panel: panelsManager.panel0.copyWith(
                        color: context.theme.cardColor,
                      ),
                      child: const AboutPanel(),
                    ),

                    //top-right
                    HomePanel(
                      panel: panelsManager.panel1.copyWith(
                        color: context.theme.canvasColor,
                      ),
                      child: const LogoPanel(),
                    ),
                  ],
                ),
              ),

              //bottom
              HomePanel(
                panel: panelsManager.panel2.copyWith(
                  color: context.theme.cardColor,
                ),
                child: ProjectsPanel(
                  itemCount: ProjectsManager.projects.length,
                  itemBuilder:
                      (context, index) => ProjectButton(
                        borderColor:
                            projectIndex == index
                                ? context.theme.canvasColor
                                : context.theme.dividerColor,
                        borderWidth: projectIndex == index ? 1.5 : 1,
                        project: ProjectsManager.projects[index],
                        onEnter: () {
                          if (mounted) {
                            setState(
                              () =>
                                  ProjectsManager.projects[index].isHovered =
                                      true,
                            );
                          }
                        },
                        onExit: () {
                          if (mounted) {
                            setState(
                              () =>
                                  ProjectsManager.projects[index].isHovered =
                                      false,
                            );
                          }
                        },
                        onPressed: () {
                          if (mounted) {
                            if (!panelsManager.panel3.enabled) {
                              setState(
                                () => panelsManager.togglePanel(context, 3),
                              );
                            }
                            setState(() => projectIndex = index);
                          }
                        },
                      ),
                ),
              ),
            ],
          ),
        ),
        //second half
        AnimatedContainer(
          duration: const Duration(milliseconds: k500mill),
          curve: Curves.easeInOutCubic,
          height: context.height(),
          width:
              panelsManager.panel3.enabled || panelsManager.panel4.enabled
                  ? context.width() / 2 - kPanelPaddingMedium
                  : 0,
          child:
              panelsManager.panel3.enabled || panelsManager.panel4.enabled
                  ? Stack(
                    children: [
                      //top
                      HomePanel(
                        panel: panelsManager.panel3.copyWith(
                          color: context.theme.cardColor,
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: k500mill),
                          transitionBuilder:
                              (child, animation) => FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                          child: ProjectDisplayPanel(
                            key: ValueKey(
                              ProjectsManager.projects[projectIndex].name,
                            ),
                            project: ProjectsManager.projects[projectIndex],
                          ),
                        ),
                      ),
                      //bottom
                      HomePanel(
                        panel: panelsManager.panel4.copyWith(
                          color: context.theme.cardColor,
                        ),
                        child: const ExperiencePanel(),
                      ),
                    ],
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
