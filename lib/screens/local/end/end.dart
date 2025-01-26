import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/end_reasons.dart';
import '/providers/board.dart';

class EndView extends StatelessWidget {
  const EndView({super.key});

  @override
  Widget build(BuildContext context) {
    String header = "";
    String subHeader = "";

    switch (context.read<Board>().endReason) {
      case EndReason.isFortressTaken:
        header = "GANARON LOS SOLDADOS";
        subHeader = "LA FORTALEZA FUE TOMADA";
      case EndReason.noOfficers:
        header = "GANARON LOS SOLDADOS";
        subHeader = "NO HAY OFICIALES EN EL TABLERO";
      case EndReason.officersCanNotMove:
        header = "GANARON LOS SOLDADOS";
        subHeader = "LOS OFICIALES NO SE PUEDEN MOVER";
      case EndReason.notEnoughSoldiers:
        header = "GANARON LOS OFICIALES";
        subHeader = "NO HAY SUFICIENTES SOLDADOS PARA TOMAR LA FORTALEZA";
      case EndReason.soldiersCanNotMove:
        header = "GANARON LOS OFICIALES";
        subHeader = "LOS SOLDADOS NO SE PUEDEN MOVER";
      default:
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            header,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            subHeader,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}
