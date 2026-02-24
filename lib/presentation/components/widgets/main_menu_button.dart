import 'package:cabo_counter/core/custom_theme.dart';
import 'package:flutter/material.dart';

class MainMenuButton extends StatefulWidget {
  const MainMenuButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final void Function() onPressed;

  final IconData icon;

  @override
  State<MainMenuButton> createState() => _MainMenuButtonState();
}

class _MainMenuButtonState extends State<MainMenuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: (_) {
          _animationController.forward();
        },
        onTapUp: (_) async {
          await _animationController.reverse();
          if (mounted) {
            widget.onPressed();
          }
        },
        onTapCancel: () {
          _animationController.reverse();
        },
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: CustomTheme.mainElementColor,
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Icon(widget.icon, size: 35),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: CustomTheme.backgroundColor.withAlpha(100),
                    blurRadius: 20,
                    spreadRadius: 20,
                    offset: const Offset(0, 0),
                  ),
                ],
                color: CustomTheme.primaryColor.withAlpha(100),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Icon(
                widget.icon,
                size: 35,
                color: CustomTheme.primaryColor.withRed(40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
