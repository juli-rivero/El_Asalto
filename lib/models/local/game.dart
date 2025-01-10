import 'package:el_asalto/models/board.dart';
import 'package:el_asalto/widgets/board_view.dart';
import 'package:el_asalto/widgets/turn_view.dart';
import 'package:flutter/material.dart';

class Game extends StatelessWidget {
  final Board board;

  const Game({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    height: constraints.maxHeight, width: constraints.maxWidth),
                child: BoardView(board: board));
          },
        ),
      ),
      floatingActionButton: TurnView(board: board),
    );
  }
}
