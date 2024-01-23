import 'package:flutter/material.dart';
import 'package:fruit_market/config/routes/router.dart';
import 'package:fruit_market/config/themes/themes.dart';
import 'package:fruit_market/core/constants/texts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
