import 'package:el_asalto/providers/config_game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SoldierCanMoveAside extends StatelessWidget {
  const SoldierCanMoveAside({super.key});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip.elevated(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedColor: Theme.of(context).highlightColor.withAlpha(200),
        label: SizedBox(
          width: double.infinity,
          child: Text(
            "LOS SOLDADOS SE PUEDEN MOVER A LOS COSTADO",
            textAlign: TextAlign.center,
          ),
        ),
        onSelected: (enabled) =>
            context.read<ConfigGame>().soldierCanMoveAside = enabled,
        selected: context.watch<ConfigGame>().soldierCanMoveAside);
  }
}
