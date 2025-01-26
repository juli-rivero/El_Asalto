import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      showSemanticsDebugger: false,
      title: "EL ASALTO",
      theme: _buildTheme(Brightness.light),
      routerConfig: router,
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(
    brightness: brightness,
    useMaterial3: true,
    primaryColor: const Color.fromARGB(255, 62, 51, 35),
    scaffoldBackgroundColor: Colors.orange.shade100,
    highlightColor: Colors.orange,
    hoverColor: Colors.orangeAccent.withAlpha(200),
    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: Colors.brown.shade900),
    splashColor: Colors.orangeAccent.shade700,
    appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
    applyElevationOverlayColor: true,
    textTheme: TextTheme(
        titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
    )),
    indicatorColor: Colors.brown.shade900,
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.playTextTheme(baseTheme.textTheme),
  );
}
