import 'package:el_asalto/models/piece_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/board.dart';

class TurnView extends StatelessWidget {
  const TurnView({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !context.watch<Board>().ended,
      child: Selector<Board, PieceType>(
          selector: (_, board) => board.turn,
          builder: (context, pieceType, child) {
            return Tooltip(
              message:
                  "Turno de los ${pieceType.isSoldier ? "soldados" : "oficiales"}",
              child: Icon(pieceType.icon),
            );
          }),
    );
  }
}
