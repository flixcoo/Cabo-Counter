import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/presentation/components/widgets/custom_stepper.dart';
import 'package:flutter/cupertino.dart';

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
  late final suffixWidget = widget.suffixWidget ?? const SizedBox.shrink();
  late final padding = suffixWidget is CustomStepper
      ? const EdgeInsets.fromLTRB(15, 0, 0, 0)
      : (suffixWidget is Icon ||
              suffixWidget is CupertinoListTileChevron ||
              suffixWidget is Row)
          ? const EdgeInsets.fromLTRB(15, 10, 8, 10)
          : const EdgeInsets.symmetric(vertical: 10, horizontal: 15);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
}
