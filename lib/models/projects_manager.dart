import 'package:portfolio_3/models/project.dart';
import 'package:portfolio_3/utils/constants.dart';

class ProjectsManager {
  static final List<Project> projects = [
    Project(
      name: 'EventsJo',
      logo: kEventsJoLogo,
      banner: kEventsJoBanner,
      platform: 'Cross-Platform',
      type: 'Application',
      isHovered: false,
    ),
    Project(
      name: 'Concentrated',
      logo: kConcentratedLogo,
      banner: kConcentratedBanner,
      platform: 'Cross-Platform',
      type: 'Application',
      isHovered: false,
    ),
    Project(
      name: 'Suqareo',
      logo: kSquareoLogo,
      banner: kSquareoBanner,
      platform: 'Cross-Platform',
      type: 'Application',
      isHovered: false,
    ),
    Project(
      name: 'Audio Resumer',
      logo: kAudioResumerLogo,
      banner: kAudioResumerBanner,
      platform: 'Web',
      type: 'Extension',
      isHovered: false,
    ),
    Project(
      name: 'DrawOverIt',
      logo: kDrawOverItLogo,
      banner: kDrawOverItBanner,
      platform: 'Desktop',
      type: 'Application',
      isHovered: false,
    ),
    Project(
      name: 'WindowsSidebar',
      logo: kWindowsSidebarLogo,
      banner: kWindowsSidebarBanner,
      platform: 'Windows',
      type: 'Application',
      isHovered: false,
    ),
    Project(
      name: 'RapidRounds',
      logo: kRapidRoundsLogo,
      banner: kRapidRoundsBanner,
      platform: 'Mobile',
      type: 'Application',
      isHovered: false,
    ),
    Project(
      name: 'Portfolio',
      logo: kPortfolioLogo,
      banner: kPortfolioBanner,
      platform: 'Web',
      type: 'Website',
      isHovered: false,
    ),
    Project(
      name: 'EventsJoBackend',
      logo: kEventsJoBackendLogo,
      banner: kEventsJoBackendBanner,
      platform: 'Cross-Platform',
      type: 'Backend',
      isHovered: false,
    ),
  ];
}
