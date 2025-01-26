import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ElAsaltoBackground extends StatelessWidget {
  final Widget child;
  const ElAsaltoBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ModelViewer(
            src: "assets/3d_objects/el_asalto.glb",
            alt: "Un modelo 3d del tablero El Asalto",
            ar: true,
            autoRotate: true,
          ),
        ),
        child,
      ],
    );
  }
}
