import 'package:flutter/material.dart';

enum SnackbarType { success, error, info }

void showModularSnackbar(BuildContext context, String message, {SnackbarType type = SnackbarType.info}) {
  Color backgroundColor;
  IconData iconData;

  switch (type) {
    case SnackbarType.success:
      backgroundColor = Colors.green;
      iconData = Icons.check_circle;
      break;
    case SnackbarType.error:
      backgroundColor = Colors.red;
      iconData = Icons.error;
      break;
    case SnackbarType.info:
      backgroundColor = Theme.of(context).colorScheme.secondary;
      iconData = Icons.info;
      break;
  }

  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(iconData, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.all(16),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}