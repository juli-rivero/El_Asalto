library;

import 'package:el_asalto/models/board.dart';
import 'package:el_asalto/models/position.dart';
import 'package:el_asalto/widgets/cell.dart';
import 'package:flutter/material.dart';

part "officer.dart";
part "soldier.dart";

enum PieceType {
  officer,
  soldier;

  bool get isOfficer => this == officer;
  bool get isSoldier => this == soldier;

  IconData get icon => switch (this) {
        officer => Icons.shield_outlined,
        soldier => Icons.close_outlined,
      };
}

abstract interface class Piece {
  PieceType get pieceType;

  Board get board;

  IconData get icon;

  CellViewState get cell;
  set cell(CellViewState newCell);

  Position get pos;

  bool canMoveTo(CellViewState newCell);

  void moveTo(CellViewState newCell);

  bool get canMove;

  void remove();
}
