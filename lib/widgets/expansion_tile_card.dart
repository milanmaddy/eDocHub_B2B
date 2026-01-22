import 'package:flutter/material.dart';

class ExpansionTileCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;

  const ExpansionTileCard({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        title: Text(title,
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0).copyWith(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
