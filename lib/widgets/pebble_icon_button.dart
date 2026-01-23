import 'package:edochub_b2b/utils/color_extensions.dart';
import 'package:flutter/material.dart';

class PebbleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;

  const PebbleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacitySafe(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: colorScheme.onSurface.withOpacitySafe(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(icon, color: iconColor ?? colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}