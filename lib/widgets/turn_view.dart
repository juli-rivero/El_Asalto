import 'package:el_asalto/models/board.dart';
import 'package:flutter/material.dart';

class TurnView extends StatelessWidget {
  const TurnView({super.key, required this.board});
  final Board board;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: board.turnNotifier,
        builder: (context, turn, _) {
          return Icon(turn.icon);
        });
  }
}
