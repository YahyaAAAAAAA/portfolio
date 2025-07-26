import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:portfolio_3/pages/home_page.dart';
import 'package:portfolio_3/utils/theme/app_theme.dart';

void main() {
  //Widgetsbinding to be initialized before running app
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //preserve splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    //remove splash screen
    FlutterNativeSplash.remove();

    return MaterialApp(
      title: 'Yahya Amarneh',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      home: const HomePage(),
    );
  }
}
