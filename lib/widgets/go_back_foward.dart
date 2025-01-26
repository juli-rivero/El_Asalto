import 'package:el_asalto/providers/board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoBackFoward extends StatelessWidget {
  const GoBackFoward({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Board>(builder: (context, board, child) {
      return Row(
        spacing: 8,
        children: [
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            minWidth: 0,
            onPressed: board.canGoBack ? () => board.goBack() : null,
            child: Icon(Icons.arrow_left_rounded),
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            minWidth: 0,
            onPressed: board.canGoForward ? () => board.goForward() : null,
            child: Icon(Icons.arrow_right_rounded),
          ),
        ],
      );
    });
  }
}
