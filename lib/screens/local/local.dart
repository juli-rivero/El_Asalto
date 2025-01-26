import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/board.dart';
import '/providers/config_game.dart';
import 'pages.dart';

class Local extends StatelessWidget {
  Local({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConfigGame()),
        ChangeNotifierProvider(
            create: (context) => Board(context.read<ConfigGame>())),
      ],
      child: PagesView(),
    );
  }
}
