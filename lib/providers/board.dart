import 'dart:math';

import 'package:flutter/material.dart';

import '/models/end_reasons.dart';
import '/models/piece_type.dart';
import '/models/pieces.dart';
import '/utils/constants.dart';
import '/models/position.dart';
import 'config_game.dart';

typedef HistoryType = ({
  Position before,
  Position after,
  (Position, PieceType)? removed,
  bool removedSelected,
});

class Board extends ChangeNotifier {
  late final ConfigGame config;

  late PieceType _turn;

  final List<HistoryType> _backHistory = [];
  final List<HistoryType> _forwardHistory = [];

  final Set<Position> soldiers = {};
  final Set<Position> officers = {};

  Board(ConfigGame newConfig) {
    config = newConfig;
    initialize();
  }

  void initialize({VoidCallback? onEnd}) {
    _turn = config.startPieceType;
    soldiers.clear();
    _generateSoldiers();
    officers.clear();
    _generateOfficers(config.numberOfOfficers);
    _endReason = null;
    deselect();
    _backHistory.clear();
    _forwardHistory.clear();
    if (onEnd != null) this.onEnd = onEnd;
    notifyListeners();
  }

  void restart() => initialize();

  void _generateOfficers(int count) {
    for (var i = 0; i < count; i++) {
      Position pos;
      do {
        pos = Position(
          column: Random().nextInt(3) + 2,
          row: Random().nextInt(3) + 4,
        );
      } while (officers.contains(pos));
      officers.add(pos);
    }
  }

  void _generateSoldiers() {
    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        var pos = Position(column: column, row: row);
        if (pos.isInBoard && !pos.isInFortress) {
          soldiers.add(pos);
        }
      }
    }
  }

  PieceType get turn => _turn;
  PieceType get nextTurn =>
      _turn.isOfficer ? PieceType.soldier : PieceType.officer;

  void operator []=(Position pos, PieceType? pieceType) {
    switch (pieceType) {
      case PieceType.soldier:
        soldiers.add(pos);
      case PieceType.officer:
        officers.add(pos);
      default:
        soldiers.remove(pos);
        officers.remove(pos);
    }
    notifyListeners();
  }

  PieceType? operator [](Position pos) {
    if (soldiers.contains(pos)) return PieceType.soldier;
    if (officers.contains(pos)) return PieceType.officer;
    return null;
  }

  void remove(Position pos) {
    soldiers.remove(pos);
    officers.remove(pos);
    notifyListeners();
  }

  Position? _selectedPosition;
  Position? get selectedPosition {
    return _selectedPosition;
  }

  PieceType? get selectedPieceType {
    return (hasSelected) ? this[_selectedPosition!] : null;
  }

  Piece? get selectedPiece {
    return switch (selectedPieceType) {
      PieceType.officer => Officer(board: this, position: selectedPosition!),
      PieceType.soldier => Soldier(board: this, position: selectedPosition!),
      _ => null
    };
  }

  set selectedPosition(Position? newSelectedPosition) {
    _selectedPosition = newSelectedPosition;
    notifyListeners();
  }

  void deselect() => selectedPosition = null;

  bool get hasSelected => _selectedPosition != null;

  bool get isFortressTaken {
    var soldiersInFortess = soldiers.fold(0, (previousValue, position) {
      return (position.isInFortress) ? previousValue + 1 : previousValue;
    });
    return soldiersInFortess >= 9;
  }

  bool get areEnoughSoldiers => soldiers.length >= numberCellsOfFortress;
  bool get isAnyOfficer => officers.isNotEmpty;
  bool get soldiersCanMove => soldiers
      .any((position) => Soldier(board: this, position: position).canMove);
  bool get officersCanMove => officers
      .any((position) => Officer(board: this, position: position).canMove);

  EndReason? _endReason;
  EndReason? get endReason => _endReason;

  VoidCallback? onEnd;

  bool get ended => _endReason != null;

  void changeTurn() {
    if (isFortressTaken) {
      _endReason = EndReason.isFortressTaken;
    } else if (!isAnyOfficer) {
      _endReason = EndReason.noOfficers;
    } else if (!areEnoughSoldiers) {
      _endReason = EndReason.notEnoughSoldiers;
    } else if (!soldiersCanMove) {
      _endReason = EndReason.soldiersCanNotMove;
    } else if (!officersCanMove) {
      _endReason = EndReason.officersCanNotMove;
    } else {
      _turn = nextTurn;
    }
    if (ended && onEnd != null) {
      onEnd!();
    }
    notifyListeners();
  }

  /* History */

  bool get canGoBack => _backHistory.isNotEmpty;
  bool get canGoForward => _forwardHistory.isNotEmpty;

  void addHistory(Position before, Position after,
      {(Position, PieceType)? removed, bool removedSelected = false}) {
    _backHistory.add((
      before: before,
      after: after,
      removed: removed,
      removedSelected: removedSelected
    ));
    _forwardHistory.clear();
    notifyListeners();
  }

  void goForward() {
    _backHistory.add(_forwardHistory.last);
    var (:before, :after, :removed, :removedSelected) =
        _forwardHistory.removeLast();
    if (turn.isSoldier) {
      soldiers.remove(before);
      soldiers.add(after);
    } else {
      officers.remove(before);
      officers.add(after);
    }
    if (removed != null) {
      removed.$2.isSoldier
          ? soldiers.remove(removed.$1)
          : officers.remove(removed.$1);
    }
    changeTurn();
    notifyListeners();
  }

  void goBack() {
    changeTurn();
    _forwardHistory.add(_backHistory.last);
    var (:before, :after, :removed, :removedSelected) =
        _backHistory.removeLast();
    if (turn.isSoldier) {
      soldiers.remove(after);
      soldiers.add(before);
    } else {
      officers.remove(after);
      officers.add(before);
    }
    if (removed != null && removed.$2.isSoldier) {
      soldiers.add(removed.$1);
    }
    if (removed != null && removed.$2.isOfficer && !removedSelected) {
      officers.add(removed.$1);
    }

    notifyListeners();
  }
}
