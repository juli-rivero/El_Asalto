import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/config_game.dart';

class InitialOfficers extends StatefulWidget {
  const InitialOfficers({super.key});

  @override
  State<InitialOfficers> createState() => _InitialOfficersState();
}

class _InitialOfficersState extends State<InitialOfficers> {
  int number = 2;

  setNumber(value) {
    setState(() {
      number = value;
    });
    context.read<ConfigGame>().numberOfOfficers = value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("CANTIDAD DE OFICIALES INICIALES"),
        DropdownButton(
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          isDense: true,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          menuWidth: 50,
          value: number,
          items: List.generate(5, (index) {
            var number = index + 1;
            return DropdownMenuItem(
              child: Text(number.toString()),
              value: number,
            );
          }),
          onChanged: setNumber,
        ),
      ],
    );
  }
}
