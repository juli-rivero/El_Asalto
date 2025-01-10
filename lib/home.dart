import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Title(
                title: "EL ASALTO",
                color: Colors.black,
                child: Text(
                  "EL ASALTO",
                  style: Theme.of(context).textTheme.displayMedium,
                )),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                spacing: 64,
                children: [
                  MenuButton(
                      text: "Modo Local",
                      onPressed: () => context.go('/local')),
                  MenuButton(text: "Modo Online")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String _text;
  final VoidCallback? _onPressed;
  const MenuButton({super.key, required String text, VoidCallback? onPressed})
      : _text = text,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return TooltipVisibility(
      visible: _onPressed == null ? true : false,
      child: Tooltip(
        message: "No disponible aún",
        padding: EdgeInsets.all(10),
        verticalOffset: -20,
        margin: EdgeInsets.only(left: 450),
        child: ElevatedButton(
            onPressed: _onPressed,
            style: ButtonStyle(
                mouseCursor: WidgetStatePropertyAll(_onPressed == null
                    ? SystemMouseCursors.forbidden
                    : SystemMouseCursors.click),
                backgroundColor: WidgetStatePropertyAll(_onPressed == null
                    ? const Color.fromARGB(24, 0, 77, 64)
                    : Colors.white),
                elevation: WidgetStatePropertyAll(16),
                fixedSize: WidgetStatePropertyAll(Size(300, 150)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(1))))),
            child:
                Text(_text, style: Theme.of(context).textTheme.headlineLarge)),
      ),
    );
  }
}
