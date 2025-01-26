import 'package:el_asalto/screens/local/config_game/widgets/can_move_aside.dart';
import 'package:el_asalto/screens/local/config_game/widgets/tips.dart';
import 'package:flutter/material.dart';

import '/widgets/progress_button.dart';

class PostConfigGameView extends StatelessWidget {
  final VoidCallback onResetConfig;
  PostConfigGameView({super.key, required this.onResetConfig});

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
                TipsCheckbox(),
                SoldierCanMoveAside(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: AutoDestroyFloatingButton(
        key: UniqueKey(),
        text: "REINICIAR CONFIGURACION",
        onPressed: onResetConfig,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
