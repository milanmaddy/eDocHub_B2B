import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final int maxLines;

  const ProfileTextField({
    super.key,
    required this.label,
    required this.initialValue,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha(153))),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withAlpha(51)),
            ),
          ),
        ),
      ],
    );
  }
}
