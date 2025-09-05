import 'package:cabo_counter/core/custom_theme.dart';
import 'package:flutter/cupertino.dart';

/// A customizable button widget using Cupertino style.
///
/// Displays a button with a child widget and optional callback.
/// The button uses a medium size, rounded corners, and a custom background color.
class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const CustomButton({super.key, required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      sizeStyle: CupertinoButtonSize.medium,
      borderRadius: BorderRadius.circular(12),
      color: CustomTheme.buttonBackgroundColor,
      onPressed: onPressed,
      child: child,
    );
  }
}
