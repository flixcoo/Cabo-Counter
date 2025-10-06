import 'dart:io';

import 'package:cabo_counter/core/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    if (Platform.isIOS) {
      return CupertinoButton(
        sizeStyle: CupertinoButtonSize.medium,
        borderRadius: BorderRadius.circular(12),
        color: CustomTheme.buttonBackgroundColor,
        onPressed: onPressed,
        child: child,
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomTheme.buttonBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
        onPressed: onPressed,
        child: DefaultTextStyle.merge(
          style: const TextStyle(fontSize: 18),
          child: child,
        ),
      );
    }
  }
}
