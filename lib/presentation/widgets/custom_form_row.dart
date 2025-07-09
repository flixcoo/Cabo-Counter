import 'package:cabo_counter/presentation/widgets/stepper.dart';
import 'package:cabo_counter/utility/custom_theme.dart';
import 'package:flutter/cupertino.dart';

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
  late Widget suffixWidget;
  @override
  void initState() {
    super.initState();
    suffixWidget = widget.suffixWidget ?? const SizedBox.shrink();
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
        padding: suffixWidget is Stepper
            ? const EdgeInsets.fromLTRB(15, 0, 0, 0)
            : const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: suffixWidget,
      ),
    );
  }
}
