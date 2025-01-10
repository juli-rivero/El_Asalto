import 'package:el_asalto/home.dart';
import 'package:el_asalto/models/local/local.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'local',
          builder: (BuildContext context, GoRouterState state) {
            return Local();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "EL ASALTO",
      theme: _buildTheme(Brightness.light),
      routerConfig: _router,
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorSchemeSeed: Colors.teal,
      textTheme: TextTheme());

  return baseTheme.copyWith(
    textTheme: GoogleFonts.kanitTextTheme(baseTheme.textTheme),
  );
}
