import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const StatCard(
      {super.key,
        required this.title,
        required this.value,
        required this.color});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: textTheme.bodyMedium?.copyWith(
                    color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
            const SizedBox(height: 8),
            Text(
              value,
              style: textTheme.headlineMedium
                  ?.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
