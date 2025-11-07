import 'package:flutter/material.dart';

enum ButtonType { elevated, outlined, text }

class ModularButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final ButtonType buttonType;
  final ButtonStyle? style;

  const ModularButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.buttonType = ButtonType.elevated,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: style,
          child: child,
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onPressed,
          style: style,
          child: child,
        );
      case ButtonType.elevated:
      default:
        return ElevatedButton(
          onPressed: onPressed,
          style: style,
          child: child,
        );
    }
  }
}