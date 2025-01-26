import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String _text;
  final VoidCallback? _onPressed;
  const MenuButton({super.key, required String text, VoidCallback? onPressed})
      : _text = text,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onPressed,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      elevation: 16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        _text,
        style: Theme.of(context).textTheme.displayMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
