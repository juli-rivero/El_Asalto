import 'dart:math';

import 'package:el_asalto/models/constants.dart';

class Position {
  int x;
  int y;
  Position({required this.x, required this.y});

  @override
  bool operator ==(Object other) {
    if (other is Position) {
      return x == other.x && y == other.y;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => x.hashCode + y.hashCode;

  int distanceFrom(Position pos) => max((x - pos.x).abs(), (y - pos.y).abs());

  Position between(Position pos) => Position(
        x: min(x, pos.x) + (x - pos.x).abs() ~/ 2,
        y: min(y, pos.y) + (y - pos.y).abs() ~/ 2,
      );

  bool get isLeftFromFortress => (x == 0 && y == 4) || (x == 1 && y == 4);
  bool get isRightFromFortress => (x == 5 && y == 4) || (x == 6 && y == 4);
  bool get isRightOrLeftFromFortress =>
      isLeftFromFortress || isRightFromFortress;

  bool get isInBoard =>
      (1 < x && x < 5 && 0 <= y && y < rows) ||
      (1 < y && y < 5 && 0 <= x && x < columns);

  bool get isInFortress => 1 < x && x < 5 && 3 < y;

  @override
  String toString() => "(x: $x, y: $y)";
}
