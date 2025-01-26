import 'package:el_asalto/models/piece_type.dart';
import 'package:el_asalto/providers/config_game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartPieceType extends StatefulWidget {
  const StartPieceType({super.key});

  @override
  State<StartPieceType> createState() => _StartPieceTypeState();
}

class _StartPieceTypeState extends State<StartPieceType> {
  PieceType pieceType = PieceType.officer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<PieceType>(
        showSelectedIcon: false,
        style: SegmentedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          selectedBackgroundColor:
              Theme.of(context).highlightColor.withAlpha(200),
        ),
        segments: [
          ButtonSegment(
              value: PieceType.officer,
              label: SizedBox(child: Text('Empiezan los oficiales')),
              icon: Icon(PieceType.officer.icon)),
          ButtonSegment(
              value: PieceType.soldier,
              label: Text('Empiezan los soldados'),
              icon: Icon(PieceType.soldier.icon)),
        ],
        selected: <PieceType>{pieceType},
        onSelectionChanged: (newSelection) {
          setState(() {
            pieceType = newSelection.first;
          });
          context.read<ConfigGame>().startPieceType = newSelection.first;
        },
      ),
    );
  }
}
