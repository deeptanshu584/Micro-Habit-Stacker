import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../models/completion_log.dart';
import '../models/habit_stack.dart';
import 'isar_provider.dart';

// Streak data for a single stack
class StreakData {
  final int currentStreak;
  final int bestStreak;
  final int totalCompletions;
  final List<DateTime> completedDates;

  const StreakData({
    required this.currentStreak,
    required this.bestStreak,
    required this.totalCompletions,
    required this.completedDates,
  });
}

// Provider that computes streak data for a given stackUid
final streakDataProvider =
    FutureProvider.family<StreakData, String>((ref, stackUid) async {
  final isar = await ref.read(isarProvider.future);

  final logs = await isar.completionLogs
      .filter()
      .stackUidEqualTo(stackUid)
      .sortByCompletedAt()
      .findAll();

  if (logs.isEmpty) {
    return const StreakData(
      currentStreak: 0,
      bestStreak: 0,
      totalCompletions: 0,
      completedDates: [],
    );
  }

  // Deduplicate by date (one completion per day counts)
  final Set<String> uniqueDays = {};
  final List<DateTime> completedDates = [];
  for (final log in logs) {
    final key =
        '${log.completedAt.year}-${log.completedAt.month}-${log.completedAt.day}';
    if (uniqueDays.add(key)) {
      completedDates.add(DateTime(
        log.completedAt.year,
        log.completedAt.month,
        log.completedAt.day,
      ));
    }
  }

  completedDates.sort();

  // Calculate current streak
  int currentStreak = 0;
  DateTime check = DateTime.now();
  check = DateTime(check.year, check.month, check.day);

  for (int i = completedDates.length - 1; i >= 0; i--) {
    final date = completedDates[i];
    if (date == check || date == check.subtract(const Duration(days: 1))) {
      currentStreak++;
      check = date.subtract(const Duration(days: 1));
    } else {
      break;
    }
  }

  // Calculate best streak
  int bestStreak = 0;
  int tempStreak = 1;
  for (int i = 1; i < completedDates.length; i++) {
    final diff = completedDates[i].difference(completedDates[i - 1]).inDays;
    if (diff == 1) {
      tempStreak++;
      if (tempStreak > bestStreak) bestStreak = tempStreak;
    } else {
      tempStreak = 1;
    }
  }
  if (bestStreak == 0 && completedDates.isNotEmpty) bestStreak = 1;
  if (currentStreak > bestStreak) bestStreak = currentStreak;

  return StreakData(
    currentStreak: currentStreak,
    bestStreak: bestStreak,
    totalCompletions: completedDates.length,
    completedDates: completedDates,
  );
});

// Provider for all stacks with their streak data combined
final allStreaksProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final isar = await ref.read(isarProvider.future);
  final stacks = await isar.habitStacks
      .filter()
      .isActiveEqualTo(true)
      .findAll();

  final result = <Map<String, dynamic>>[];
  for (final stack in stacks) {
    final streakData = await ref.read(streakDataProvider(stack.uid).future);
    result.add({'stack': stack, 'streak': streakData});
  }
  return result;
});
