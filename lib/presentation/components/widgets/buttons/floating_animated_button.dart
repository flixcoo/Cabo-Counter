import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';

class FloatingAnimatedButton extends StatefulWidget {
  const FloatingAnimatedButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  final void Function() onPressed;
  final IconData icon;
  final String text;

  @override
  State<FloatingAnimatedButton> createState() => _FloatingAnimatedButtonState();
}

class _FloatingAnimatedButtonState extends State<FloatingAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: GestureDetector(
        onTapDown: (_) {
          animationController.forward();
        },
        onTapUp: (_) async {
          await animationController.reverse();
          if (mounted) {
            VibrationService.selectionClick();
            widget.onPressed();
          }
        },
        onTapCancel: () {
          animationController.reverse();
        },
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: CustomTheme.white,
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.icon, size: 24, color: Colors.black),
                  const SizedBox(width: 8),
                  Text(
                    widget.text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
