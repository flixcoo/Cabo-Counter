import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogAction extends StatelessWidget {
  final void Function() onPressed;
  final bool isDefaultAction;
  final bool isDestructiveAction;
  final String actionText;
  const CustomDialogAction({
    super.key,
    required this.onPressed,
    required this.actionText,
    this.isDestructiveAction = false,
    this.isDefaultAction = false,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoDialogAction(
        onPressed: () => Navigator.of(context).pop(),
        isDefaultAction: isDefaultAction,
        isDestructiveAction: isDestructiveAction,
        child: Text(actionText),
      );
    } else {
      return TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          actionText,
          style: TextStyle(
              color: isDestructiveAction
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
              fontWeight: isDefaultAction || isDestructiveAction
                  ? FontWeight.bold
                  : FontWeight.normal),
        ),
      );
    }
  }
}
