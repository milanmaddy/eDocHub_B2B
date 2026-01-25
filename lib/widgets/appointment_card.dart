import 'package:edochub_b2b/utils/color_extensions.dart';
import 'package:edochub_b2b/widgets/modular_button.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String name;
  final String time;
  final String type;
  final String avatarUrl;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.time,
    required this.type,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text('$time\n$type', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacitySafe(0.6))),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ModularButton(
                    buttonType: ButtonType.outlined,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                      side: BorderSide(color: Theme.of(context).colorScheme.error),
                    ),
                    onPressed: () {},
                    child: const Text('Decline'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ModularButton(
                    onPressed: () {},
                    child: const Text('Accept'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
