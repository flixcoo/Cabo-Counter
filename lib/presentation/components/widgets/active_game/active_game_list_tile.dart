import 'package:cabo_counter/core/custom_theme.dart';
import 'package:flutter/cupertino.dart';

class ActiveGameListTile extends StatefulWidget {
  const ActiveGameListTile({
    super.key,
    required this.title,
    this.trailing,
    this.padding,
    this.onTap,
    this.showDisabledState = false,
  });

  final Widget title;

  final Widget? trailing;

  final EdgeInsets? padding;

  final VoidCallback? onTap;

  final bool showDisabledState;

  @override
  State<ActiveGameListTile> createState() => _ActiveGameListTileState();
}

class _ActiveGameListTileState extends State<ActiveGameListTile> {
  bool isPressed = false;
  bool isDisabled = false;

  @override
  void initState() {
    super.initState();
    isDisabled = widget.onTap == null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: isDisabled
          ? null
          : (_) {
              setState(() => isPressed = true);
            },
      onTapUp: (_) async {
        await Future.delayed(const Duration(milliseconds: 250));
        setState(() => isPressed = false);
      },
      onTap: widget.onTap,
      child: AnimatedOpacity(
        opacity: isPressed
            ? 0.6
            : (widget.showDisabledState && isDisabled)
            ? 0.3
            : 1.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          color: CustomTheme.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.title,
              widget.trailing ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
