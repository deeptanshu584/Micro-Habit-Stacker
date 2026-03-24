import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../../../models/habit_stack.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  // Call once at app startup
  static Future<void> init() async {
    tz.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(settings);
    await _requestPermissions();
  }

  static Future<void> _requestPermissions() async {
    // Android 13+ requires explicit permission
    final android = _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();

    // iOS
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    await ios?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // Schedule a daily notification for a habit stack
  static Future<void> scheduleStackReminder(HabitStack stack) async {
    if (stack.reminderHour == -1) return; // No reminder set

    // Use a unique int ID derived from the stack uid
    final notifId = stack.uid.hashCode.abs() % 100000;

    await _plugin.zonedSchedule(
      notifId,
      '${stack.emoji} Time to stack!',
      'After you ${stack.triggerHabit} — ${stack.newHabit}',
      _nextInstanceOfTime(stack.reminderHour, stack.reminderMinute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'habit_reminders',
          'Habit Reminders',
          channelDescription: 'Daily reminders for your habit stacks',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // repeats daily
    );
  }

  // Cancel notification for a specific stack
  static Future<void> cancelStackReminder(HabitStack stack) async {
    final notifId = stack.uid.hashCode.abs() % 100000;
    await _plugin.cancel(notifId);
  }

  // Cancel ALL notifications (used on app reset)
  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  // Reschedule all active stacks (call on app startup)
  static Future<void> rescheduleAll(List<HabitStack> stacks) async {
    await _plugin.cancelAll();
    for (final stack in stacks) {
      if (stack.reminderHour != -1 && stack.isActive) {
        await scheduleStackReminder(stack);
      }
    }
  }

  // Helper: get next TZDateTime for a given hour:minute
  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    // If the time has already passed today, schedule for tomorrow
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
