part of './pieces.dart';

class Officer implements Piece {
  @override
  CellViewState cell;

  @override
  final Board board;

  Officer({required this.cell, required this.board}) {
    board.officers.add(this);
  }

  @override
  Position get pos => cell.pos;

  @override
  PieceType get pieceType => PieceType.officer;

  @override
  IconData get icon => PieceType.officer.icon;

  @override
  bool canMoveTo(CellViewState? newCell) =>
      newCell != null && newCell.isEmpty && pos.distanceFrom(newCell.pos) == 1;

  Piece? between(CellViewState cell) {
    var posBetween = pos.between(cell.pos);
    var cellBetween = board.inPos(posBetween).currentState;
    return cellBetween?.piece;
  }

  bool canJumpTo(CellViewState? newCell) {
    if (newCell == null || newCell.isNotEmpty) {
      return false;
    }
    var pieceBetween = between(newCell);
    if (pieceBetween == null || !pieceBetween.pieceType.isSoldier) {
      return false;
    }
    if (pos.distanceFrom(newCell.pos) != 2 ||
        (pos.x - newCell.pos.x) % 2 != 0 ||
        (pos.y - newCell.pos.y) % 2 != 0) {
      return false;
    }
    return true;
  }

  @override
  bool get canMove {
    for (var x = -1; x <= 1; x++) {
      for (var y = -1; y <= 1; y++) {
        var currentPos = Position(x: pos.x + x, y: pos.y + y);
        if (!currentPos.isInBoard) {
          continue;
        }
        var currentCell = board.inPos(currentPos).currentState;
        if (currentCell != null && currentCell.isEmpty) {
          return true;
        }
      }
    }
    return false;
  }

  bool get canJump {
    for (var x = -1; x <= 1; x++) {
      for (var y = -1; y <= 1; y++) {
        var currentPos = Position(x: pos.x + x, y: pos.y + y);
        if (!currentPos.isInBoard) {
          continue;
        }
        var currentCell = board.inPos(currentPos).currentState;
        if (currentCell != null &&
            currentCell.isNotEmpty &&
            currentCell.pieceType.isSoldier) {
          currentPos = Position(x: pos.x + 2 * x, y: pos.y + 2 * y);
          if (!currentPos.isInBoard) {
            continue;
          }
          currentCell = board.inPos(currentPos).currentState;
          if (currentCell != null && currentCell.isEmpty) {
            return true;
          }
        }
      }
    }
    return false;
  }

  @override
  void moveTo(CellViewState newCell) {
    cell.clear();
    newCell.piece = this;
    cell = newCell;
  }

  @override
  void remove() {
    cell.clear();
    board.officers.remove(this);
  }
}
