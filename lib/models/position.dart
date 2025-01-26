import 'dart:math';

import '/utils/constants.dart';

class Position {
  int column;
  int row;
  Position({required this.column, required this.row});

  @override
  bool operator ==(Object other) {
    if (other is Position) {
      return column == other.column && row == other.row;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => column.hashCode + row.hashCode;

  int distanceFrom(Position pos) =>
      max((column - pos.column).abs(), (row - pos.row).abs());

  Position between(Position pos) => Position(
        column: min(column, pos.column) + (column - pos.column).abs() ~/ 2,
        row: min(row, pos.row) + (row - pos.row).abs() ~/ 2,
      );

  bool get isLeftFromFortress =>
      (column == 0 && row == 4) || (column == 1 && row == 4);
  bool get isRightFromFortress =>
      (column == 5 && row == 4) || (column == 6 && row == 4);
  bool get isRightOrLeftFromFortress =>
      isLeftFromFortress || isRightFromFortress;

  bool get isInBoard =>
      (1 < column && column < 5 && 0 <= row && row < rows) ||
      (1 < row && row < 5 && 0 <= column && column < columns);

  bool get isInFortress => 1 < column && column < 5 && 3 < row;

  @override
  String toString() => "(column: $column, row: $row)";
}
