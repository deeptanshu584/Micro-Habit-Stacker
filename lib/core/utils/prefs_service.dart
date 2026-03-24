import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Onboarding
  static bool get hasSeenOnboarding =>
      _prefs.getBool('has_seen_onboarding') ?? false;

  static Future<void> setOnboardingComplete() =>
      _prefs.setBool('has_seen_onboarding', true);

  // Theme (reserved for future use)
  static String get theme => _prefs.getString('theme') ?? 'dark_warm';

  static Future<void> setTheme(String theme) =>
      _prefs.setString('theme', theme);

  // Streak freeze toggle
  static bool get streakFreezeEnabled =>
      _prefs.getBool('streak_freeze_enabled') ?? true;

  static Future<void> setStreakFreeze(bool value) =>
      _prefs.setBool('streak_freeze_enabled', value);

  // Clear all data (used in Settings > Reset)
  static Future<void> clearAll() => _prefs.clear();
}
