import 'package:el_asalto/models/board.dart';
import 'package:flutter/material.dart';

class EndView extends StatelessWidget {
  final Board board;

  const EndView({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: board.ended,
      builder: (context, ended, child) => ended
          ? DraggableScrollableSheet(
              initialChildSize: 1,
              maxChildSize: 1,
              minChildSize: 0.1,
              expand: true,
              shouldCloseOnMinExtent: false,
              snapSizes: [0.33, 0.45],
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      PreferredSize(
                        preferredSize:
                            Size.fromHeight(100.0), // Altura arbitraria
                        child: AppBar(
                          centerTitle: true,
                          leading: Container(),
                          backgroundColor: Colors.blueGrey.withAlpha(200),
                          title: Icon(Icons.drag_handle_rounded),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          )),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 1 - 75,
                        color: Colors.blueGrey.withAlpha(200),
                        child: Align(
                          alignment: FractionalOffset(.5, .45),
                          child: Text(
                            "FIN DE PARTIDA",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })
          : Container(),
    );
  }
}
