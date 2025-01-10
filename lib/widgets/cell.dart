import 'package:flutter/material.dart';

import '../models/board.dart';
import '../models/pieces/pieces.dart';
import '../models/position.dart';

class CellView extends StatefulWidget {
  final PieceType? _initialPieceType;
  final Position pos;
  final Board board;

  final void Function(CellViewState)? _onPressed;

  const CellView({
    super.key,
    required this.pos,
    required this.board,
    PieceType? initialPieceType,
    void Function(CellViewState)? onPressed,
  })  : _onPressed = onPressed,
        _initialPieceType = initialPieceType;

  bool get isFortress => pos.isInFortress;

  @override
  State<CellView> createState() => CellViewState();
}

class CellViewState extends State<CellView> {
  Piece? _piece;

  bool _selected = false;

  void clear() => setState(() {
        _piece = null;
        _selected = false;
      });

  @override
  void initState() {
    _piece = switch (widget._initialPieceType) {
      PieceType.officer => Officer(cell: this, board: widget.board),
      PieceType.soldier => Soldier(cell: this, board: widget.board),
      _ => null,
    };
    super.initState();
  }

  set selected(bool selected) => setState(() => _selected = selected);
  bool get selected => _selected;

  Piece? get piece {
    return _piece;
  }

  set piece(Piece? newPiece) {
    assert(_piece == null);
    setState(() => _piece = newPiece);
  }

  bool get isEmpty => _piece == null;
  bool get isNotEmpty => _piece != null;

  Position get pos => widget.pos;

  PieceType get pieceType {
    assert(_piece != null);
    return _piece!.pieceType;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: _selected
          ? BoxDecoration(color: Colors.blueGrey.withAlpha(150))
          : null,
      child: ElevatedButton(
        onPressed: () =>
            widget._onPressed != null ? widget._onPressed!(this) : null,
        style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(1)),
                side: BorderSide(
                    strokeAlign: BorderSide.strokeAlignCenter, width: 4))),
            backgroundColor: WidgetStatePropertyAll(
              widget.isFortress
                  ? Colors.deepOrangeAccent.shade200
                  : Colors.white,
            ),
            surfaceTintColor:
                WidgetStatePropertyAll(_selected ? Colors.black : null)),
        child: FractionallySizedBox(
          heightFactor: 0.5,
          widthFactor: 0.5,
          child: FittedBox(
            child: Icon(
              _piece?.icon,
              color: const Color.fromARGB(255, 62, 51, 35),
              weight: 700,
            ),
          ),
        ),
      ),
    );
  }
}
