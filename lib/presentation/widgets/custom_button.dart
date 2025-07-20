import 'package:cabo_counter/core/custom_theme.dart';
import 'package:flutter/cupertino.dart';

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
