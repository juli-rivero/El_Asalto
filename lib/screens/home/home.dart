import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'background.dart';
import 'menu_button.dart';
import 'title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ElAsaltoTitle(),
      ),
      body: ElAsaltoBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: MenuButton(
                  text: "JUGAR", onPressed: () => context.go('/local')),
            ),
          ],
        ),
      ),
    );
  }
}
