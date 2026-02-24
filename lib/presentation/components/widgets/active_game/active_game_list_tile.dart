import 'package:cabo_counter/core/custom_theme.dart';
import 'package:flutter/cupertino.dart';

class ActiveGameListTile extends StatefulWidget {
  const ActiveGameListTile({
    super.key,
    required this.title,
    this.trailing,
    this.padding,
    this.onTap,
  });

  final Widget title;

  final Widget? trailing;

  final EdgeInsets? padding;
  final VoidCallback? onTap;

  @override
  State<ActiveGameListTile> createState() => _ActiveGameListTileState();
}

class _ActiveGameListTileState extends State<ActiveGameListTile> {
  bool _isPressed = false;

  void _resetPressedState() {
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        setState(() => _isPressed = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (widget.onTap != null) setState(() => _isPressed = true);
      },
      onTapUp: (_) => _resetPressedState(),
      onTapCancel: () => _resetPressedState(),
      onTap: widget.onTap,
      child: AnimatedOpacity(
        opacity: _isPressed ? 0.4 : 1.0,
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
