import 'package:flutter/services.dart';
import 'prefs_service.dart';

/// Centralized haptic helper that respects the user's toggle.
///
/// Usage — replace `HapticFeedback.selectionClick()` with:
/// ```dart
/// HapticHelper.selectionClick();
/// ```
class HapticHelper {
  HapticHelper._();

  static void selectionClick() {
    if (PrefsService.hapticsEnabled) HapticFeedback.selectionClick();
  }

  static void lightImpact() {
    if (PrefsService.hapticsEnabled) HapticFeedback.lightImpact();
  }

  static void mediumImpact() {
    if (PrefsService.hapticsEnabled) HapticFeedback.mediumImpact();
  }

  static void heavyImpact() {
    if (PrefsService.hapticsEnabled) HapticFeedback.heavyImpact();
  }
}
