import 'package:el_asalto/models/board.dart';
import 'package:flutter/material.dart';

import '../models/position.dart';
import '../models/pieces/pieces.dart';
import '../models/constants.dart';
import '../widgets/cell.dart';

class BoardView extends StatelessWidget {
  final Board board;

  const BoardView({super.key, required this.board});

  void onPressed(CellViewState cell) {
    if (board.ended.value) {
      board.selectedCell = null;
      return;
    }

    board.selectedCell?.selected = false;

    if (cell.isEmpty && board.hasSelected) {
      Officer? officerInDefault;
      var selectedPiece = board.selectedPiece!;
      if (selectedPiece is Officer) {
        if (selectedPiece.canJump) {
          officerInDefault = selectedPiece;
        } else {
          for (var officer in board.officers) {
            if (officer == selectedPiece) continue;
            if (officer.canJump) {
              officerInDefault = officer;
              break;
            }
          }
        }
      }
      if (selectedPiece.canMoveTo(cell)) {
        selectedPiece.moveTo(cell);
        if (officerInDefault != null) officerInDefault.remove();
        board.changeTurn();
      } else if (selectedPiece is Officer && selectedPiece.canJumpTo(cell)) {
        selectedPiece.between(cell)!.remove();
        selectedPiece.moveTo(cell);
        board.changeTurn();
      }
    }

    board.selectedCell = null;
    if (cell.isNotEmpty && cell.pieceType == board.turn) {
      cell.selected = true;
      board.selectedCell = cell;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: rows * columns,
        itemBuilder: (BuildContext context, int index) {
          var pos = Position(x: index % columns, y: index ~/ columns);
          if (!pos.isInBoard) {
            return SizedBox();
          }
          PieceType? initialPieceType;
          if (board.soldiersInitialPositions.contains(pos)) {
            initialPieceType = PieceType.soldier;
          }
          if (board.officersInitialPositions.contains(pos)) {
            initialPieceType = PieceType.officer;
          }
          return CellView(
            board: board,
            pos: pos,
            initialPieceType: initialPieceType,
            key: board.inPos(pos),
            onPressed: onPressed,
          );
        });
  }
}
