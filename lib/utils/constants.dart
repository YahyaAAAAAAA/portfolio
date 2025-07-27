import 'package:portfolio_3/models/project_segmet.dart';

const double kOuterBorderRadius = 5;
const double kInnerBorderRadius = 12;

const double kPanelPaddingSmall = 5;
const double kPanelPaddingMedium = 15;

const double kIconSizeSmall = 17;
const double kIconSizeMedium = 20;
const double kIconSizeLarge = 25;

const double kAppBarHeight = 58;

const double kMobileBreakpoint = 700;

const int k500mill = 500;
const int k2000mill = 2000;

const String kFontFamily = 'PPNeueMontreal';

//assets
const String kUniUrl = 'https://www.hu.edu.jo/';
const String kUniImage =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752816557/uni_edqulh.png';
const String kUniImageHash = 'LFHLe-0=-:I[5_I_-oM}K8InaIaJ';
const kHopeInternationalUrl = 'https://www.thehope-tech.com/';
const String kHopeInternational =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1753198811/thehope_kzvf4b.png';
const String kHopeInternationalHash = 'LMONB,of^-W.%Mj[axfQ^-WV9XoM';
const kJYIFUrl = 'https://jyif.org/';
const String kJYIF =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752816540/yjif_wjdjca.png';
const String kJYIFHash = 'LMM~;0xapw%0}oVynPS0}=RQt6v|';
const kCoachYouUrl = 'https://www.coachyou.io/#/';
const String kCoachYou =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752816532/coachyou_cajw99.png';
const String kCoachYouHsh = 'LEEolwcu}ZnI{Y5c+*Ex{eb.[Q6.';
const String kLogoFilledImage =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752816548/logo_filled_shadow_qdiljk.png';
const String kLogoImage =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752816525/logo_inside_app_shadow_vhyvoy.png';
const String kDecorationModel1 =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752816574/model11_ev0gcc.gif';
const String kDecorationModel2 =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752817217/model8_scxru2.gif';
const String kAssetDecorationModel1 = 'assets/images/model12.gif';
const String kAssetDecorationModel2 = 'assets/images/model8.gif';
const String kAssetWave = 'assets/images/wave.json';

const double kExperienceButtonWidth = 300;
const double kExperienceButtonHeight = 230;
const double kSkillButtonWidth = 150;
const double kSkillButtonHeight = 40;
const double kSillButtonSpacing = 30;

//--projects--

//eventsjo
const String kEventsJoLogo =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752814495/events_jo_logo_lkci2i.png';
const String kEventsJoBanner =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752814919/events_jo_banner_abxdan.png';
const String kEventsJoGithub = 'https://github.com/YahyaAAAAAAA/events-jo';
const String kEventsJoWebsite = 'https://yahyaaaaaaaa.github.io/events-jo/';
const String kEventsJoVideo =
    'https://res.cloudinary.com/ddixv6xdj/video/upload/v1752747571/EventsJo_Video_w1gxls.mp4';
const List<String> kEventsJoScreenshots = [
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813821/home_lqinke.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813819/details_q0egyi.png',
  // 'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813812/rating_vobhmb.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813804/details2_uq1luj.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813804/search_azd7qh.png',
  // 'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813778/checkout_xwnbvl.png',
  // 'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813716/create3_cilk8w.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813713/create_e4tkmz.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813707/book_a8ruct.png',
  // 'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813700/accountowner_chipz3.png',
  // 'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813686/about_pkln07.png',
  // 'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813682/accountuser_n32zrz.png',
  // 'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813645/privacy_ry1au0.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813641/ownervenues_jkun6z.png',
  // 'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813637/password_rjcn5r.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813724/admin_loyvdr.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813733/admin7_m4rdsr.png',
  // 'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813720/admin3_m7ytu3.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813708/admin9_xsqccb.png',
  // 'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813699/admin4_kspgg5.png',
];
const List<ProjectSegment> kEventsJoSegments = [
  ProjectSegment(
    title: 'Introduction',
    description:
        'EventsJo is a cross-platform mobile application designed to simplify the process of booking venues for various events in Jordan, including weddings, farm gatherings, and football courts.\nBuilt using Flutter and powered by Firebase, EventsJo provides a seamless experience for users to browse, book, and manage event reservations.',
  ),
  ProjectSegment(
    title: 'Features',
    description:
        '• Venue Booking: Reserve wedding halls, farms, and football courts.\n• User Authentication: Secure login and registration system.\n• Payment Options: Choose between cash payments or secure credit card transactions.\n• Notifications: Receive real-time updates and reminders for upcoming events.\n• Event Tracking: Track scheduled and past reservations.',
  ),
  ProjectSegment(
    title: 'Technologies',
    description:
        '• Frontend: Flutter with Dart.\n• Backend: Firebase (Firestore, Authentication), NodeJs, Cloudinary, Render.\n• State Management: BLoC.\n• Payment Gateway: Stripe.',
  ),
];

//concentrated
const String kConcentratedLogo =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752814209/concentrated_logo_wuq9rl.png';
const String kConcentratedBanner =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752814879/concentrated_banner_ibtx97.png';
const String kConcentratedGithub =
    'https://github.com/YahyaAAAAAAA/concentrated';
const List<String> kConcentratedScreenshots = [
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813480/1_l7eujo.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813470/2_qwidbp.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813466/3_k2oh2z.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813476/4_kahaby.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813474/5_qfoohy.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813483/6_cflayy.png',
];
const List<ProjectSegment> kConcentratedSegments = [
  ProjectSegment(
    title: 'Introduction',
    description:
        'Concentrated is a cross-platform mobile application for taking and creating exams and quizzes.\nThe project focuses on showcasing clean-architecture, MVVM, and SOLID principles in Flutter.',
  ),
  ProjectSegment(
    title: 'Features',
    description:
        '• Exam Creation: Create exams and quizzes with multiple-choice questions.\n• Exam Taking: Take exams and quizzes.\n• Exam Results: View exam results and statistics.\n• Exam Management: Manage exams and quizzes.\n• Exam Tracking: Track exam results and statistics.',
  ),
  ProjectSegment(
    title: 'Technologies',
    description:
        '• Frontend: Flutter with Dart.\n• Backend: Firebase (Firestore, Authentication).\n• State Management: BLoC.',
  ),
];

//squareo
const String kSquareoLogo =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752814662/squareo_logo_em27r2.png';
const String kSquareoBanner =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752815231/squareo_banner_gsezrz.png';
const String kSquareoGithub = 'https://github.com/YahyaAAAAAAA/squareo';
const String kSquareoWebsite = 'https://squareoweb.github.io/';
const String kSquareoVideo =
    'https://res.cloudinary.com/ddixv6xdj/video/upload/v1752814000/Suqareo_Video_sm3zx1.mp4';
const List<String> kSquareoScreenshots = [
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813953/1_c4s5qg.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813946/2_fl2gou.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813957/3_ahwfrg.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813944/4_dv2co8.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813963/5_nz4bvs.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813964/6_inshkk.png',
];
const List<ProjectSegment> kSquareoSegments = [
  ProjectSegment(
    title: 'Introduction',
    description:
        'Welcome to Squareo, an engaging mobile puzzle game where your objective is to restore a grid of squares to its original state. The grid moves over time, adding a challenging twist that tests your memory, spatial awareness, and problem-solving skills.',
  ),
  ProjectSegment(
    title: 'Game Objective',
    description:
        'The primary goal of Squareo is to reposition each square on the grid back to its original location. The faster and more efficiently you do this, the higher your score and grade.',
  ),
  ProjectSegment(
    title: 'Controls',
    description:
        '• Drag: Move the selected square to the desired location.\n• Release: Place the square in the new position.',
  ),
  ProjectSegment(
    title: 'Technologies',
    description:
        '• Frontend: Flutter with Dart.\n• Backend: Hive\n• State Management: GetX.',
  ),
];

//audioResumer
const String kAudioResumerLogo =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752814180/audio_resumer_logo_cc42mx.png';
const String kAudioResumerBanner =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752814836/audio_resumer_banner_xiwicf.png';
const String kAudioResumerGithub =
    'https://github.com/YahyaAAAAAAA/audio-resumer';
const List<String> kAudioResumerScreenshots = [
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813420/1_ynjgnr.png',
];
const List<ProjectSegment> kAudioResumerSegments = [
  ProjectSegment(
    title: 'Introduction',
    description:
        'a chrome extension that let you set a tab to your liking, this tab will play it\'s audio as long as no other tab is playing an audio.',
  ),
  ProjectSegment(
    title: 'Usage',
    description:
        '1- Click on the extension icon in the Chrome toolbar.\n2- Select a tab to control by clicking the "Set Tab" button.\n3- The selected tab will play audio unless another tab starts playing audio.\n4- Use the "Clear Tab" button to remove the controlled tab.\n5- Jump to the controlled tab with the provided button in the popup.',
  ),
];

//drawOverIt
const String kDrawOverItLogo =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752814277/draw_over_it_logo_mleung.png';
const String kDrawOverItBanner =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752814901/draw_over_it_banner_ukwldc.png';
const String kDrawOverItGithub = 'https://github.com/YahyaAAAAAAA/draw-over-it';
const String kDrawOverItVideo =
    'https://res.cloudinary.com/ddixv6xdj/video/upload/v1752814028/DrawOverIt_Video_ue8esx.mp4';
const List<ProjectSegment> kDrawOverItSegments = [
  ProjectSegment(
    title: 'Introduction',
    description:
        'Draw Over It is a Windows application that make you draw over any window just press (ALT+Q), the app runs in the background.',
  ),
  ProjectSegment(
    title: 'Technologies',
    description: 'Draw Over It is developed using the framework Flutter.',
  ),
];

//windowsSidebar
const String kWindowsSidebarLogo =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752814710/windows_sidebar_logo_pl7kkn.png';
const String kWindowsSidebarBanner =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752814818/windows_sidebar_banner_goup4d.png';
const String kWindowsSidebarGithub =
    'https://github.com/YahyaAAAAAAA/windows-sidebar';
const List<ProjectSegment> kWindowsSidebarSegments = [
  ProjectSegment(
    title: 'Introduction',
    description: 'A Windows sidebar tool for quick and easy file access.',
  ),
  ProjectSegment(
    title: 'Technologies',
    description: 'WindowsSidebar is developed using the framework Flutter.',
  ),
];

//rapidRounds
const String kRapidRoundsLogo =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752814600/rapid_rounds_logo_l6j9yz.png';
const String kRapidRoundsBanner =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752815185/rapid_rounds_banner_ysonl9.png';
const String kRapidRoundsGithub =
    'https://github.com/YahyaAAAAAAA/rapid-rounds';
const List<String> kRapidRoundsScreenshots = [
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813902/1_c7hwhk.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813894/2_f6utfd.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813880/3_yl01gw.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813890/4_cxougq.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813894/5_bsqozd.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813905/6_hl60wj.png',
  'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752813876/7_z4itmk.png',
];
const List<ProjectSegment> kRapidRoundsSegments = [
  ProjectSegment(
    title: 'Introduction',
    description:
        'RapidRounds is multi-player game that is a set of mini-games where the faster to solve the games wins.',
  ),
  ProjectSegment(
    title: 'Technologies',
    description:
        '• Frontend: Flutter with Dart.\n• Backend: Firebase.\n• State Management: BLoC.',
  ),
];

//portfolio
const String kPortfolioLogo =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752816183/portfolio_logo_fg96oi.png';
const String kPortfolioBanner =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752816192/portfolio_banner_xowrtu.png';
const String kPortfolioGithub = 'https://github.com/YahyaAAAAAAA/portfolio';
const List<ProjectSegment> kPortfolioSegments = [
  ProjectSegment(
    title: 'Introduction',
    description: 'A portfolio website for my projects.',
  ),
  ProjectSegment(
    title: 'Technologies',
    description: '• Frontend: Flutter with Dart.',
  ),
];
//eventsJoBackend
const String kEventsJoBackendLogo =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752814548/events_jo_backend_logo_dpjqxd.png';
const String kEventsJoBackendBanner =
    'https://res.cloudinary.com/ddixv6xdj/image/upload/v1752814970/events_jo_backend_banner_jfe6kf.jpg';
const String kEventsJoBackendGithub =
    'https://github.com/YahyaAAAAAAA/events-jo-stripe-backend';
const List<ProjectSegment> kEventsJoBackendSegments = [
  ProjectSegment(
    title: 'Introduction',
    description: 'A backend for the EventsJo project that handles the payment.',
  ),
  ProjectSegment(
    title: 'Technologies',
    description: '• Backend: NodeJs, Stripe, Render.',
  ),
];
