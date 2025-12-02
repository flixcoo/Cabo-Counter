import 'dart:io';

import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/presentation/components/widgets/custom_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A customizable form row widget with a prefix icon, text, and optional suffix widget.
///
/// Displays a row with an icon and text on the left side.
/// Optionally, a suffix widget (e.g. a stepper) can be shown on the right side.
/// The row is styled as a [CupertinoButton] and can react to taps.
class CustomFormRow extends StatefulWidget {
  final String prefixText;
  final IconData prefixIcon;
  final Widget? suffixWidget;
  final void Function()? onPressed;
  const CustomFormRow({
    super.key,
    required this.prefixText,
    required this.prefixIcon,
    this.onPressed,
    this.suffixWidget,
  });

  @override
  State<CustomFormRow> createState() => _CustomFormRowState();
}

class _CustomFormRowState extends State<CustomFormRow> {
  @override
  void initState() {
    super.initState();
    print('Suffix widget is : ${widget.suffixWidget.runtimeType}');
  }

  @override
  Widget build(BuildContext context) {
    final suffixWidget = widget.suffixWidget ?? const SizedBox.shrink();
    final padding = _calculatePadding(suffixWidget);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: widget.onPressed,
      child: CupertinoFormRow(
        prefix: Row(
          children: [
            Icon(
              widget.prefixIcon,
              color: CustomTheme.primaryColor,
            ),
            const SizedBox(width: 10),
            Text(widget.prefixText),
          ],
        ),
        padding: padding,
        child: suffixWidget,
      ),
    );
  }

  /// Calculates padding based on the type of the suffix widget.
  EdgeInsets _calculatePadding(Widget suffixWidget) {
    if (suffixWidget is CustomStepper) {
      return const EdgeInsets.fromLTRB(15, 0, 0, 0);
    } else if (suffixWidget is Icon ||
        suffixWidget is CupertinoListTileChevron ||
        suffixWidget is Row) {
      return const EdgeInsets.fromLTRB(15, 10, 8, 10);
    } else if (suffixWidget is Material) {
      if (Platform.isIOS) {
        return const EdgeInsets.fromLTRB(15, 0, 10, 0);
      } else {
        return const EdgeInsets.fromLTRB(15, 0, 8, 0);
      }
    } else {
      return const EdgeInsets.symmetric(vertical: 10, horizontal: 15);
    }
  }
}
