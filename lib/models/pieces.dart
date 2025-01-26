library;

import 'piece_type.dart';
import 'position.dart';
import '/providers/board.dart';

sealed class Piece {
  Position get position;

  bool get hasMoved;

  bool canMoveTo(Position newPosition);

  void tryMoveTo(Position newPosition);

  void remove();

  bool get canMove;
}

class Soldier implements Piece {
  final Board _board;

  Position _position;
  @override
  Position get position => _position;

  Soldier({required Board board, required Position position})
      : _board = board,
        _position = position;

  bool _hasMoved = false;
  @override
  bool get hasMoved => _hasMoved;

  @override
  bool canMoveTo(Position newPosition) =>
      _board[newPosition] == null &&
      (((position.isLeftFromFortress || _board.config.soldierCanMoveAside) &&
              newPosition.row == position.row &&
              newPosition.column == position.column + 1) ||
          ((position.isRightFromFortress ||
                  _board.config.soldierCanMoveAside) &&
              newPosition.row == position.row &&
              newPosition.column == position.column - 1) ||
          (!position.isRightOrLeftFromFortress &&
              (position.column - 1 <= newPosition.column &&
                  newPosition.column <= position.column + 1) &&
              newPosition.row == position.row + 1));

  @override
  void tryMoveTo(Position newPosition) {
    if (canMoveTo(newPosition)) {
      _board.remove(position);
      _board[newPosition] = PieceType.soldier;
      _position = newPosition;
      _hasMoved = true;
    }
  }

  @override
  void remove() {
    _board.remove(position);
  }

  @override
  bool get canMove {
    var isEmptyCell = (Position newPosition) =>
        newPosition.isInBoard && _board[newPosition] == null;
    if (position.isLeftFromFortress || _board.config.soldierCanMoveAside) {
      var newPosition =
          Position(column: position.column + 1, row: position.row);
      if (isEmptyCell(newPosition)) return true;
    }
    if (position.isRightFromFortress || _board.config.soldierCanMoveAside) {
      var newPosition =
          Position(column: position.column - 1, row: position.row);
      if (isEmptyCell(newPosition)) return true;
    }
    if (!position.isRightOrLeftFromFortress) {
      for (var x = -1; x <= 1; x++) {
        var newPosition =
            Position(column: position.column + x, row: position.row + 1);
        if (isEmptyCell(newPosition)) return true;
      }
    }
    return false;
  }
}

class Officer implements Piece {
  final Board _board;

  Position _position;
  @override
  Position get position => _position;

  Officer({required Board board, required Position position})
      : _board = board,
        _position = position;

  bool get isInFortress => position.isInFortress;

  bool _hasMoved = false;
  @override
  bool get hasMoved => _hasMoved;
  bool _hasJumped = false;
  bool get hasJumped => _hasJumped;

  bool canWalkTo(Position newPosition) =>
      _board[newPosition] == null && position.distanceFrom(newPosition) == 1;

  bool canJumpTo(Position newPosition) =>
      (newPosition.isInBoard && _board[newPosition] == null) &&
      (_board[position.between(newPosition)] == PieceType.soldier) &&
      (position.distanceFrom(newPosition) == 2 &&
          (position.column - newPosition.column) % 2 == 0 &&
          (position.row - newPosition.row) % 2 == 0);

  @override
  bool canMoveTo(Position newPosition) =>
      canWalkTo(newPosition) || canJumpTo(newPosition);

  @override
  void tryMoveTo(Position newPosition) {
    if (canWalkTo(newPosition)) {
      _board.remove(position);
      _board[newPosition] = PieceType.officer;
      _position = newPosition;
      _hasMoved = true;
    }
    if (canJumpTo(newPosition)) {
      _board.remove(position);
      _board.remove(position.between(newPosition));
      _board[newPosition] = PieceType.officer;
      _position = newPosition;
      _hasMoved = true;
      _hasJumped = true;
    }
  }

  @override
  void remove() {
    _board.remove(position);
  }

  @override
  bool get canMove {
    return canJump || canWalk;
  }

  bool get canWalk {
    for (var x = -1; x <= 1; x++) {
      for (var y = -1; y <= 1; y++) {
        var currentPos =
            Position(column: position.column + x, row: position.row + y);
        if (currentPos.isInBoard && _board[currentPos] == null) {
          return true;
        }
      }
    }
    return false;
  }

  bool get canJump {
    for (var x = -1; x <= 1; x++) {
      for (var y = -1; y <= 1; y++) {
        var currentPos =
            Position(column: position.column + x, row: position.row + y);
        if (currentPos.isInBoard && _board[currentPos] == PieceType.soldier) {
          currentPos = Position(
              column: position.column + 2 * x, row: position.row + 2 * y);
          if (currentPos.isInBoard && _board[currentPos] == null) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
