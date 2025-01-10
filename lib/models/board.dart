import 'dart:math';

import 'package:el_asalto/models/constants.dart';
import 'package:el_asalto/models/pieces/pieces.dart';
import 'package:el_asalto/models/position.dart';
import 'package:el_asalto/widgets/cell.dart';
import 'package:flutter/material.dart';

class Board {
  final ValueNotifier<PieceType> turnNotifier;
  final ValueNotifier<bool> ended = ValueNotifier(false);

  final soldiers = <Soldier>{};
  final soldiersInFortress = <Soldier>{};
  final officers = <Officer>{};

  bool get isFortressTaken => soldiersInFortress.length == 9;
  bool get isAnySoldier => soldiers.isNotEmpty;
  bool get isAnyOfficer => officers.isNotEmpty;
  bool get soldiersCanMove => soldiers.any((soldier) => soldier.canMove);
  bool get officersCanMoveOrJump =>
      officers.any((officer) => officer.canMove || officer.canJump);

  bool get officersCanJump => officers.any((officer) => officer.canJump);

  PieceType get turn => turnNotifier.value;
  PieceType get nextTurn =>
      turn.isOfficer ? PieceType.soldier : PieceType.officer;

  CellViewState? selectedCell;

  Piece? get selectedPiece => selectedCell?.piece;
  set selectedPiece(Piece? selected) => selectedCell = selected?.cell;

  bool get hasSelected => selectedCell != null;

  Board({PieceType startPiece = PieceType.officer})
      : turnNotifier = ValueNotifier(startPiece) {
    generateOfficersPositions();
    generateSoldierPositions();
  }

  void changeTurn() {
    turnNotifier.value = nextTurn;
    if (isFortressTaken ||
        !isAnySoldier ||
        !isAnyOfficer ||
        !soldiersCanMove ||
        !officersCanMoveOrJump) {
      ended.value = true;
    }
  }

  final _board = List.generate(
      rows, (_) => List.generate(columns, (_) => GlobalKey<CellViewState>()));

  GlobalKey<CellViewState> inPos(Position pos) => _board[pos.y][pos.x];

  final soldiersInitialPositions = <Position>{};

  void generateSoldierPositions() {
    soldiersInitialPositions.clear();
    for (var y = 0; y < rows; y++) {
      for (var x = 0; x < columns; x++) {
        var pos = Position(x: x, y: y);
        if (pos.isInBoard && !pos.isInFortress) {
          soldiersInitialPositions.add(pos);
        }
      }
    }
  }

  final officersInitialPositions = <Position>{};

  void generateOfficersPositions() {
    officersInitialPositions.clear();
    for (var i = 0; i < 2; i++) {
      Position pos;
      do {
        pos = Position(
          x: Random().nextInt(3) + 2,
          y: Random().nextInt(3) + 4,
        );
      } while (officersInitialPositions.contains(pos));
      officersInitialPositions.add(pos);
    }
  }
}
