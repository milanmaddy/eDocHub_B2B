import 'package:flutter/material.dart';

enum ButtonType { elevated, outlined }

class ModularButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final ButtonStyle? style;
  final ButtonType buttonType;

  const ModularButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
    this.buttonType = ButtonType.elevated, // Default to elevated
  });

  @override
  State<ModularButton> createState() => _ModularButtonState();
}

class _ModularButtonState extends State<ModularButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
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
      onTapDown: (_) => _glowController.forward(),
      onTapUp: (_) {
        _glowController.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _glowController.reverse(),
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 - (_glowAnimation.value * 0.05),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.7 * _glowAnimation.value),
                    spreadRadius: 2 + (2 * _glowAnimation.value),
                    blurRadius: 8 + (4 * _glowAnimation.value),
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: child,
            ),
          );
        },
        child: _buildButton(),
      ),
    );
  }

  Widget _buildButton() {
    switch (widget.buttonType) {
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: () {
            // The onTap of the GestureDetector is used instead.
          },
          style: widget.style,
          child: widget.child,
        );
      case ButtonType.elevated:
      default:
        return ElevatedButton(
          onPressed: () {
            // The onTap of the GestureDetector is used instead.
          },
          style: widget.style,
          child: widget.child,
        );
    }
  }
}