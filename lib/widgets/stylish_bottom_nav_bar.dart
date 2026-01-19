import 'package:flutter/material.dart';
import 'package:edochub_b2b/utils/color_extensions.dart';

class StylishBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;

  const StylishBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacitySafe(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: SizedBox(
        height: 56,
        child: Stack(
          children: [
            // The animated "pill"
            AnimatedAlign(
              alignment: Alignment(-1.0 + (currentIndex / (items.length - 1)) * 2, 0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: FractionallySizedBox(
                widthFactor: 1 / items.length,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacitySafe(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            // The row of icons and labels
            Row(
              children: List.generate(items.length, (index) {
                final item = items[index];
                final bool isSelected = currentIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(index),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: isSelected ? 1.15 : 1.0,
                          curve: Curves.easeOut,
                          child: Icon(
                            isSelected ? (item.activeIcon as Icon).icon : (item.icon as Icon).icon,
                            color: isSelected ? colorScheme.primary : colorScheme.onSurface.withOpacitySafe(0.6),
                          ),
                        ),
                        const SizedBox(height: 2),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: isSelected ? 1.0 : 0.0,
                          child: Text(
                            item.label ?? '',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}