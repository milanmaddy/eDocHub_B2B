import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();

    // Navigate after a fixed time, no longer waits for location.
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/location');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/icon.png',
                      width: 48,
                      height: 48,
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 1.5,
                      color: colorScheme.primary.withAlpha(204),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: 'eDoc Hub ',
                                style: TextStyle(color: colorScheme.onSurface),
                              ),
                              TextSpan(
                                text: 'B2B',
                                style: TextStyle(color: colorScheme.primary),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Your Wellness, in Your Hands.',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withAlpha(179),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Text(
                  'v1.0.0',
                  style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withAlpha(102)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
