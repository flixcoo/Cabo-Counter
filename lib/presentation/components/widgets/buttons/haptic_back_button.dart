import 'package:cabo_counter/presentation/components/widgets/buttons/animated_icon_button.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:flutter/cupertino.dart';

class HapticBackButton extends StatefulWidget {
  const HapticBackButton({super.key});

  @override
  State<HapticBackButton> createState() => _HapticBackButtonState();
}

class _HapticBackButtonState extends State<HapticBackButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedIconButton(
      icon: IconService.back,
      onPressed: () async {
        Navigator.of(context).maybePop();
      },
    );
  }
}
