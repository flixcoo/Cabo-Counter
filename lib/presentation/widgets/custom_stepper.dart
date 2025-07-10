import 'package:cabo_counter/core/custom_theme.dart';
import 'package:flutter/cupertino.dart'; // Für iOS-Style

class CustomStepper extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int? initialValue;
  final int step;
  final ValueChanged<int> onChanged;
  const CustomStepper({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.step,
    required this.onChanged,
    this.initialValue,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  late int _value;

  @override
  void initState() {
    super.initState();
    final start = widget.initialValue ?? widget.minValue;
    _value = start.clamp(widget.minValue, widget.maxValue);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _decrement,
          child: const Icon(CupertinoIcons.minus),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text('$_value',
              style: TextStyle(fontSize: 18, color: CustomTheme.white)),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _increment,
          child: const Icon(CupertinoIcons.add),
        ),
      ],
    );
  }

  void _increment() {
    if (_value + widget.step <= widget.maxValue) {
      setState(() {
        _value += widget.step;
        widget.onChanged.call(_value);
      });
    }
  }

  void _decrement() {
    if (_value - widget.step >= widget.minValue) {
      setState(() {
        _value -= widget.step;
        widget.onChanged.call(_value);
      });
    }
  }
}
