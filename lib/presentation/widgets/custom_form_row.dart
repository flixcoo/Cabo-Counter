import 'package:cabo_counter/utility/custom_theme.dart';
import 'package:flutter/cupertino.dart';

class CustomFormRow extends StatefulWidget {
  final String prefixText;
  final IconData prefixIcon;
  final Widget? suffixWidget;
  final void Function()? onTap;
  const CustomFormRow({
    super.key,
    required this.prefixText,
    required this.prefixIcon,
    required this.onTap,
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
    return GestureDetector(
      onTap: widget.onTap,
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: suffixWidget,
      ),
    );
  }
}
