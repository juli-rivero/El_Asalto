import 'package:el_asalto/screens/local/config_game/widgets/can_move_aside.dart';
import 'package:el_asalto/screens/local/config_game/widgets/tips.dart';
import 'package:flutter/material.dart';

import '/widgets/progress_button.dart';
import 'widgets/initial_officers.dart';
import 'widgets/start_piece_type.dart';

class PreConfigGameView extends StatelessWidget {
  final VoidCallback onEndConfig;
  PreConfigGameView({super.key, required this.onEndConfig});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500, minWidth: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              spacing: 16,
              children: [
                InitialOfficers(),
                StartPieceType(),
                TipsCheckbox(),
                SoldierCanMoveAside(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: AutoDestroyFloatingButton(
        text: "INICIAR PARTIDA",
        onPressed: onEndConfig,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
