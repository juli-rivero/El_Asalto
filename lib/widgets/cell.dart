import 'package:el_asalto/events/on_tap.dart';
import 'package:el_asalto/models/piece_type.dart';
import 'package:el_asalto/providers/config_game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/board.dart';
import '/models/position.dart';

class CellView extends StatelessWidget {
  final Position position;
  final double size;
  const CellView({super.key, required this.position, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: () => onTap(context, position),
        style: CellView.getButtonStyle(context, position),
        child: IconCell(position: position),
      ),
    );
  }

  static Color _getBackgroundColor(BuildContext context, Position position) {
    var primaryColor =
        position.isInFortress ? Theme.of(context).highlightColor : Colors.white;
    if (!context.watch<Board>().hasSelected) return primaryColor;
    var board = context.read<Board>();
    if (board.selectedPosition == position) {
      return Color.alphaBlend(Colors.blueGrey.withAlpha(150), primaryColor);
    }
    if (context.watch<ConfigGame>().areTipsEnabled &&
        board.selectedPiece!.canMoveTo(position)) {
      return Color.alphaBlend(Colors.deepOrangeAccent, primaryColor);
    }
    return primaryColor;
  }

  static ButtonStyle getButtonStyle(BuildContext context, Position position) {
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(1)),
        side: BorderSide(
          strokeAlign: BorderSide.strokeAlignCenter,
          width: 4,
        ),
      ),
      backgroundColor: _getBackgroundColor(context, position),
    );
  }
}

class IconCell extends StatelessWidget {
  final Position position;
  const IconCell({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5,
      widthFactor: 0.5,
      child: FittedBox(
        child: Selector<Board, PieceType?>(
          selector: (_, board) => board[position],
          builder: (context, pieceType, child) {
            return Icon(
              pieceType?.icon,
              color: Theme.of(context).iconTheme.color,
              weight: 700,
            );
          },
        ),
      ),
    );
  }
}
