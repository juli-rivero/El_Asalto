import 'dart:math';

import 'package:el_asalto/utils/constants.dart';
import 'package:flutter/material.dart';

import '/models/position.dart';
import 'cell.dart';

class BoardView extends StatelessWidget {
  BoardView({super.key});

  Row _buildRow(int initial, int end, double cellSize, int rowIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        end - initial,
        (index) => CellView(
            size: cellSize,
            position: Position(column: index + initial, row: rowIndex)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double cellSize =
          min(constraints.maxWidth, constraints.maxHeight) / (matrixSize + 1);
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildRow(2, 5, cellSize, 0),
          _buildRow(2, 5, cellSize, 1),
          _buildRow(0, 7, cellSize, 2),
          _buildRow(0, 7, cellSize, 3),
          _buildRow(0, 7, cellSize, 4),
          _buildRow(2, 5, cellSize, 5),
          _buildRow(2, 5, cellSize, 6),
        ],
      );
    });
  }
}
