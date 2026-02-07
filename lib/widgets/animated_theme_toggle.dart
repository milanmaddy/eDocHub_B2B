import 'package:flutter/material.dart';
import 'package:edochub_b2b/utils/app_theme.dart';

class AnimatedThemeToggle extends StatefulWidget {
  const AnimatedThemeToggle({super.key});

  @override
  State<AnimatedThemeToggle> createState() => _AnimatedThemeToggleState();
}

class _AnimatedThemeToggleState extends State<AnimatedThemeToggle> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppTheme.mode,
      builder: (context, mode, _) {
        final isDark = mode == ThemeMode.dark;
        return GestureDetector(
          onTap: AppTheme.toggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SizedBox(
              width: 60,
              height: 28,
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 250),
                    alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: isDark ? colorScheme.primary : colorScheme.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Icon(
                          isDark ? Icons.dark_mode : Icons.light_mode,
                          key: ValueKey(isDark),
                          size: 16,
                          color: isDark ? colorScheme.onPrimary : colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
