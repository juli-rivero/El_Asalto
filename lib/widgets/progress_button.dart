import 'package:flutter/material.dart';

class AutoDestroyFloatingButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  const AutoDestroyFloatingButton(
      {super.key, required this.text, this.onPressed});

  @override
  State<AutoDestroyFloatingButton> createState() =>
      _AutoDestroyFloatingButtonState();
}

class _AutoDestroyFloatingButtonState extends State<AutoDestroyFloatingButton> {
  bool _destroyed = false;

  void _onPressed() {
    if (widget.onPressed != null) widget.onPressed!();
    setState(() {
      _destroyed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_destroyed,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        onPressed: _onPressed,
        child: Text(widget.text),
      ),
    );
  }
}
