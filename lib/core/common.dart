import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

void vibrateIfPossible() async {
  try {
    if (await Vibration.hasVibrator()) {
      if (await Vibration.hasCustomVibrationsSupport()) {
        await Vibration.vibrate(preset: VibrationPreset.doubleBuzz);
      } else {
        await Vibration.vibrate();
      }
    }
  } catch (e) {
    print('Vibration error: $e');
  }
}
