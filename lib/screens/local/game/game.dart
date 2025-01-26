import 'package:el_asalto/widgets/go_back_foward.dart';
import 'package:flutter/material.dart';

import '/widgets/board_view.dart';
import '/widgets/turn_view.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BoardView(),
      floatingActionButton: Row(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          GoBackFoward(),
          TurnView(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
