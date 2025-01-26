import 'package:flutter/material.dart';

class ElAsaltoTitle extends StatelessWidget {
  const ElAsaltoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Title(
        title: "EL ASALTO",
        color: const Color.fromARGB(255, 62, 51, 35),
        child: Text(
          "EL ASALTO",
          style: Theme.of(context).textTheme.titleLarge,
        ));
  }
}
