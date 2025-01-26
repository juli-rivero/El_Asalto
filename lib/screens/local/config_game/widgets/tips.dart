import 'package:el_asalto/providers/config_game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipsCheckbox extends StatelessWidget {
  const TipsCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip.elevated(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedColor: Theme.of(context).highlightColor.withAlpha(200),
        label: SizedBox(
          width: double.infinity,
          child: Text(
            "HABILITAR AYUDA",
            textAlign: TextAlign.center,
          ),
        ),
        onSelected: (enabled) =>
            context.read<ConfigGame>().areTipsEnabled = enabled,
        selected: context.watch<ConfigGame>().areTipsEnabled);
  }
}
