import 'package:flutter/material.dart';
import 'package:portfolio_3/pages/home_page.dart';
import 'package:portfolio_3/utils/theme/app_theme.dart';
import 'package:portfolio_3/utils/theme/theme_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(create: (_) => ThemeNotifier(), child: const App()),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final purple = context.watch<ThemeNotifier>().purple;
    return MaterialApp(
      title: 'Portfolio',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(purple: purple),
      home: HomePage(),
    );
  }
}
