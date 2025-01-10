import 'dart:math';

import 'package:el_asalto/models/board.dart';
import 'package:el_asalto/models/pieces/pieces.dart';
import 'package:el_asalto/widgets/board_view.dart';
import 'package:el_asalto/widgets/turn_view.dart';
import 'package:flutter/material.dart';

class Local extends StatelessWidget {
  Local({super.key});

  final board = Board(startPiece: PieceType.officer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SizedBox(
                width: min(constraints.maxWidth, constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.all(
                      constraints.maxWidth == constraints.maxHeight ? 100 : 16),
                  child: BoardView(board: board),
                )),
          ),
        ),
      ),
      floatingActionButton: TurnView(board: board),
    );
  }
}
