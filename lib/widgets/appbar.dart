import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/board.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool backButton;
  final bool restartButton;
  final VoidCallback? onBack;
  final VoidCallback? onRestart;
  const CustomAppBar({
    super.key,
    this.backButton = true,
    this.restartButton = true,
    this.onBack,
    this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (backButton)
            Tooltip(
              message: "Volver a la pantalla principal",
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (onBack != null) onBack!();
                },
                icon: Icon(Icons.home_rounded),
              ),
            ),
          if (restartButton)
            Tooltip(
              message: "Reiniciar partida",
              child: IconButton(
                onPressed: () {
                  context.read<Board>().restart();
                  if (onRestart != null) onRestart!();
                },
                icon: Icon(Icons.restart_alt_rounded),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
