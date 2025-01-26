import 'package:el_asalto/models/piece_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/pieces.dart';
import '/models/position.dart';
import '/providers/board.dart';

void onTap(BuildContext context, Position newPosition) {
  var board = context.read<Board>();

  if (board.ended) return;

  if (board[newPosition] != null) {
    onTapOrigin(board, newPosition);
  } else {
    onTapDestination(board, newPosition);
  }
}

void onTapOrigin(Board board, Position newPosition) {
  if (newPosition != board.selectedPosition &&
      board[newPosition] == board.turn) {
    board.selectedPosition = newPosition;
  } else {
    board.deselect();
  }
}

void onTapDestination(Board board, Position newPosition) {
  if (!board.hasSelected) return;

  var selectedPiece = board.selectedPiece!;
  var position = board.selectedPosition!;

  Officer? officerInDefault = getFirstOfficerWhoCanJump(board, selectedPiece);

  selectedPiece.tryMoveTo(newPosition);

  if (selectedPiece.hasMoved) {
    (Position, PieceType)? removed;
    if (selectedPiece is Officer) {
      if (selectedPiece.hasJumped) {
        var soldierPosition = position.between(newPosition);
        removed = (soldierPosition, PieceType.soldier);
      } else if (officerInDefault != null) {
        removed = (officerInDefault.position, PieceType.officer);
        officerInDefault.remove();
      }
    }
    board.addHistory(position, newPosition,
        removed: removed, removedSelected: officerInDefault == selectedPiece);
    board.deselect();
    board.changeTurn();
  }
}

Officer? getFirstOfficerWhoCanJump(Board board, Piece selectedPiece) {
  if (selectedPiece is Officer) {
    if (selectedPiece.canJump) {
      return selectedPiece;
    }
    for (var position in board.officers) {
      if (position == selectedPiece.position) continue;
      Officer officer = Officer(board: board, position: position);
      if (officer.canJump) return officer;
    }
  }
  return null;
}
