import 'package:flutter/material.dart';
import 'package:portfolio_3/pages/home_page.dart';
import 'package:portfolio_3/utils/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yahya Amarneh',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      home: const HomePage(),
    );
  }
}
