part of 'pieces.dart';

class Soldier implements Piece {
  @override
  CellViewState cell;

  @override
  final Board board;

  Soldier({required this.cell, required this.board}) {
    board.soldiers.add(this);
  }

  bool get isInFortress => pos.isInFortress;

  @override
  Position get pos => cell.pos;

  @override
  PieceType get pieceType => PieceType.soldier;

  @override
  IconData get icon => PieceType.soldier.icon;

  @override
  bool canMoveTo(CellViewState? newCell) =>
      newCell != null &&
      newCell.isEmpty &&
      ((pos.isLeftFromFortress &&
              newCell.pos.y == pos.y &&
              newCell.pos.x == pos.x + 1) ||
          (pos.isRightFromFortress &&
              newCell.pos.y == pos.y &&
              newCell.pos.x == pos.x - 1) ||
          (!pos.isRightOrLeftFromFortress &&
              (pos.x - 1 <= newCell.pos.x && newCell.pos.x <= pos.x + 1) &&
              newCell.pos.y == pos.y + 1));

  @override
  void moveTo(CellViewState newCell) {
    cell.clear();
    newCell.piece = this;
    cell = newCell;
    if (isInFortress) {
      board.soldiersInFortress.add(this);
    }
  }

  @override
  void remove() {
    cell.clear();
    board.soldiers.remove(this);
    board.soldiersInFortress.remove(this);
  }

  @override
  bool get canMove {
    for (var x = -1; x <= 1; x++) {
      var currentPos = Position(x: pos.x + x, y: pos.y + 1);
      if (!currentPos.isInBoard) {
        continue;
      }
      var currentCell = board.inPos(currentPos).currentState;
      if (currentCell != null && currentCell.isEmpty) {
        return true;
      }
    }
    return false;
  }
}
