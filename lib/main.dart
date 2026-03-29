import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'app.dart';
import 'database/isar_service.dart';
import 'core/utils/notification_service.dart';
import 'core/utils/prefs_service.dart';
import 'models/habit_stack.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init all services
  await IsarService.init();
  await NotificationService.init();
  await PrefsService.init();

  // Reschedule all notifications on startup
  final isar = IsarService.instance;
  final stacks = await isar.habitStacks
      .filter()
      .isActiveEqualTo(true)
      .findAll();
  await NotificationService.rescheduleAll(stacks);

  runApp(const ProviderScope(child: MicroHabitApp()));
}
