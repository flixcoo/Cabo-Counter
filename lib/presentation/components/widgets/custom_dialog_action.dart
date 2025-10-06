import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogAction<T> extends StatelessWidget {
  final String actionText;
  final bool isDefaultAction;
  final bool isDestructiveAction;
  final T? returnValue;
  final VoidCallback? onAfterPop;

  const CustomDialogAction({
    super.key,
    required this.actionText,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.returnValue,
    this.onAfterPop,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoDialogAction(
            isDefaultAction: isDefaultAction,
            isDestructiveAction: isDestructiveAction,
            onPressed: () {
              Navigator.of(context).pop(returnValue);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                onAfterPop?.call();
              });
            },
            child: Text(actionText),
          )
        : TextButton(
            onPressed: () {
              Navigator.of(context).pop(returnValue);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                onAfterPop?.call();
              });
            },
            child: Text(actionText),
          );
  }
}
