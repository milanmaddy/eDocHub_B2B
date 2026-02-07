import 'package:edochub_b2b/widgets/pebble_icon_button.dart';
import 'package:edochub_b2b/widgets/animated_theme_toggle.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final VoidCallback onNotificationsPressed;
  final VoidCallback onProfileTap;
  final String userName;
  final String userLocation;

  const DashboardHeader({
    super.key,
    required this.onNotificationsPressed,
    required this.onProfileTap,
    required this.userName,
    required this.userLocation,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: onProfileTap,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Icon(
                      Icons.person,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 18,
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                userLocation,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const AnimatedThemeToggle(),
              const SizedBox(width: 12),
              PebbleIconButton(
                icon: Icons.notifications_outlined,
                onPressed: onNotificationsPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
