import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/cupertino.dart';

class ActiveGameListTile extends StatefulWidget {
  const ActiveGameListTile({
    super.key,
    required this.title,
    this.trailing,
    this.onTap,
    this.showDisabledState = false,
    this.showChevron = false,
  });

  final Widget title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showDisabledState;
  final bool showChevron;

  @override
  State<ActiveGameListTile> createState() => _ActiveGameListTileState();
}

class _ActiveGameListTileState extends State<ActiveGameListTile> {
  bool isPressed = false;
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    isDisabled = widget.onTap == null;

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
      onTap: () {
        if (widget.onTap != null) {
          VibrationService.selectionClick();
          widget.onTap!.call();
        }
      },
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                spacing: 5,
                children: [
                  if (widget.trailing != null) widget.trailing!,
                  if (widget.showChevron)
                    Icon(
                      IconService.chevron,
                      size: 17,
                      color: CustomTheme.hintTextColor,
                    )
                  else
                    // A little more space to the right when no chevron is shown
                    const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
