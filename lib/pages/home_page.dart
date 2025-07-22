import 'package:flutter/material.dart';
import 'package:portfolio_3/models/panels_manager.dart';
import 'package:portfolio_3/models/projects_manager.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/widgets/app/app_app_bar.dart';
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
  static const double mobileBreakpoint = 600.0;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Don't pass context in initState, it might not be fully ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    // Initialize here if not already done
    if (!_isInitialized) {
      panelsManager = PanelsManager(context);
      panelsManager.init();
      _isInitialized = true;
    }
  }

  bool get isMobileView => MediaQuery.of(context).size.width < mobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    // Don't build if not initialized
    if (!_isInitialized) {
      return const NoiseWrapper(
        child: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    // Only call onToggleCheck for desktop view and if mounted
    if (!isMobileView && mounted) {
      panelsManager.onToggleCheck(context);
    }

    return NoiseWrapper(
      child: Scaffold(
        appBar: AppAppBar(
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
    );
  }

  Widget _buildMobileLayout() {
    return ListView(
      key: const ValueKey('mobile_layout'),
      children: [
        // About Panel
        if (panelsManager.panel0.enabled)
          Padding(
            padding: const EdgeInsets.only(bottom: kPanelPaddingSmall),
            child: SizedBox(
              height: 300, // Fixed height for mobile
              width: double.infinity, // Ensure full width
              child: HomePanel(
                panel: panelsManager.panel0.copyWith(
                  width: double.infinity,
                  height: 300,
                  maxWidth: double.infinity,
                  minWidth: 0,
                  maxHeight: 300,
                  minHeight: 300,
                  axis: Axis.vertical, // Change to vertical for mobile
                ),
                child: const AboutPanel(),
              ),
            ),
          ),

        // Logo Panel
        if (panelsManager.panel1.enabled)
          Padding(
            padding: const EdgeInsets.only(bottom: kPanelPaddingSmall),
            child: SizedBox(
              height: 200, // Fixed height for mobile
              width: double.infinity, // Ensure full width
              child: HomePanel(
                panel: panelsManager.panel1.copyWith(
                  width: double.infinity,
                  height: 200,
                  maxWidth: double.infinity,
                  minWidth: 0,
                  maxHeight: 200,
                  minHeight: 200,
                  axis: Axis.vertical, // Change to vertical for mobile
                  isExpanded: false, // Disable expansion in mobile
                ),
                child: const LogoPanel(),
              ),
            ),
          ),

        // Projects Panel
        if (panelsManager.panel2.enabled)
          Padding(
            padding: const EdgeInsets.only(bottom: kPanelPaddingSmall),
            child: SizedBox(
              height: 255, // Keep original height
              width: double.infinity,
              child: HomePanel(
                panel: panelsManager.panel2.copyWith(
                  width: double.infinity,
                  maxWidth: double.infinity,
                  minWidth: 0,
                ),
                child: ProjectsPanel(
                  itemCount: ProjectsManager.projects.length,
                  itemBuilder:
                      (context, index) => ProjectButton(
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
                            setState(() => projectIndex = index);
                          }
                        },
                      ),
                ),
              ),
            ),
          ),

        // Project Display Panel
        if (panelsManager.panel3.enabled)
          Padding(
            padding: const EdgeInsets.only(bottom: kPanelPaddingSmall),
            child: SizedBox(
              height: 400, // Fixed height for mobile
              width: double.infinity,
              child: HomePanel(
                panel: panelsManager.panel3.copyWith(
                  width: double.infinity,
                  height: 400,
                  maxWidth: double.infinity,
                  minWidth: 0,
                  maxHeight: 400,
                  minHeight: 400,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                  child: ProjectDisplayPanel(
                    key: ValueKey(ProjectsManager.projects[projectIndex].name),
                    project: ProjectsManager.projects[projectIndex],
                  ),
                ),
              ),
            ),
          ),

        // Experience Panel
        if (panelsManager.panel4.enabled)
          Padding(
            padding: const EdgeInsets.only(bottom: kPanelPaddingSmall),
            child: SizedBox(
              height: 300, // Fixed height for mobile
              width: double.infinity,
              child: HomePanel(
                panel: panelsManager.panel4.copyWith(
                  width: double.infinity,
                  height: 300,
                  maxWidth: double.infinity,
                  minWidth: 0,
                  maxHeight: 300,
                  minHeight: 300,
                ),
                child: const ExperiencePanel(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: [
        // First half
        AnimatedContainer(
          duration: const Duration(milliseconds: k500mill),
          curve: Curves.easeInOutCubic,
          height: MediaQuery.of(context).size.height,
          width:
              panelsManager.panel3.enabled || panelsManager.panel4.enabled
                  ? MediaQuery.of(context).size.width / 2 - kPanelPaddingMedium
                  : MediaQuery.of(context).size.width - kPanelPaddingMedium * 2,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Top-left
                    if (panelsManager.panel0.enabled)
                      HomePanel(
                        panel: panelsManager.panel0,
                        child: const AboutPanel(),
                      ),
                    // Top-right
                    if (panelsManager.panel1.enabled)
                      HomePanel(
                        panel: panelsManager.panel1,
                        child: const LogoPanel(),
                      ),
                  ],
                ),
              ),
              // Bottom
              if (panelsManager.panel2.enabled)
                HomePanel(
                  panel: panelsManager.panel2,
                  child: ProjectsPanel(
                    itemCount: ProjectsManager.projects.length,
                    itemBuilder:
                        (context, index) => ProjectButton(
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
                              setState(() => projectIndex = index);
                            }
                          },
                        ),
                  ),
                ),
            ],
          ),
        ),
        // Second half
        AnimatedContainer(
          duration: const Duration(milliseconds: k500mill),
          curve: Curves.easeInOutCubic,
          height: context.height(),
          width:
              panelsManager.panel3.enabled || panelsManager.panel4.enabled
                  ? MediaQuery.of(context).size.width / 2 - kPanelPaddingMedium
                  : 0,
          child:
              panelsManager.panel3.enabled || panelsManager.panel4.enabled
                  ? Stack(
                    children: [
                      // Top
                      HomePanel(
                        panel: panelsManager.panel3,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
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
                      // Bottom
                      HomePanel(
                        panel: panelsManager.panel4,
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
