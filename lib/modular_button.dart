import 'package:flutter/material.dart';

class ModularButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final ButtonStyle? style;

  const ModularButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
  });

  @override
  State<ModularButton> createState() => _ModularButtonState();
}

class _ModularButtonState extends State<ModularButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _isPressed ? 0.95 : 1.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(
                        _isPressed ? 1.0 : 0.5 * _glowAnimation.value),
                    spreadRadius: _isPressed ? 4 : 2 * _glowAnimation.value,
                    blurRadius: _isPressed ? 12 : 8 * _glowAnimation.value,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: child,
            ),
          );
        },
        child: ElevatedButton(
          onPressed: () {
            // The onTap of the GestureDetector is used instead
          },
          style: widget.style,
          child: widget.child,
        ),
      ),
    );
  }
}