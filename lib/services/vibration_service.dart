import 'package:cabo_counter/services/config_service.dart';
import 'package:flutter/services.dart';

class VibrationService {
  /// Triggers light haptic feedback for a selection change.
  /// Only triggers if haptic feedback is enabled in the configuration.
  static void selectionClick() {
    if (ConfigService.getVibrationsEnabled()) {
      HapticFeedback.selectionClick();
    }
  }

  /// Triggers haptic feedback for a successful action.
  /// Only triggers if haptic feedback is enabled in the configuration.
  static void successNotification() {
    if (ConfigService.getVibrationsEnabled()) {
      HapticFeedback.successNotification();
    }
  }

  /// Triggers haptic feedback for a warning.
  /// Only triggers if haptic feedback is enabled in the configuration.
  static void warningNotification() {
    if (ConfigService.getVibrationsEnabled()) {
      HapticFeedback.warningNotification();
    }
  }

  /// Triggers haptic feedback for an error.
  /// Only triggers if haptic feedback is enabled in the configuration.
  static void errorNotification() {
    if (ConfigService.getVibrationsEnabled()) {
      HapticFeedback.errorNotification();
    }
  }

  /// Triggers a light impact haptic feedback.
  /// Only triggers if haptic feedback is enabled in the configuration.
  static void lightImpact() {
    if (ConfigService.getVibrationsEnabled()) {
      HapticFeedback.lightImpact();
    }
  }

  /// Triggers a medium impact haptic feedback.
  /// Only triggers if haptic feedback is enabled in the configuration.
  static void mediumImpact() {
    if (ConfigService.getVibrationsEnabled()) {
      HapticFeedback.mediumImpact();
    }
  }

  /// Triggers a heavy impact haptic feedback.
  /// Only triggers if haptic feedback is enabled in the configuration.
  static void heavyImpact() {
    if (ConfigService.getVibrationsEnabled()) {
      HapticFeedback.heavyImpact();
    }
  }
}
