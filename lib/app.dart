import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/prefs_service.dart';
import 'screens/home/home_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';

class MicroHabitApp extends ConsumerWidget {
  const MicroHabitApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Micro Habit Stacker',
      theme: AppTheme.darkWarm,
      debugShowCheckedModeBanner: false,
      home: PrefsService.hasSeenOnboarding
          ? const HomeScreen()
          : const OnboardingScreen(),
    );
  }
}
