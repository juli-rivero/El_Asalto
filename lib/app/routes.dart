import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/screens/home/home.dart';
import '/screens/local/local.dart';

final GoRouter router = GoRouter(
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
