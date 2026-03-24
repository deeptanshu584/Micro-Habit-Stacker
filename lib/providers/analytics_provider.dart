import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../models/completion_log.dart';
import '../models/habit_stack.dart';
import 'isar_provider.dart';

class AnalyticsData {
  final int totalCompletions;
  final int totalStacks;
  final double overallCompletionRate;
  final int bestDayStreak;
  final List<int> weekdayCounts;     // Mon-Sun completions
  final List<int> last30DayCounts;   // daily completions last 30 days
  final Map<int, int> moodCounts;    // 1=meh, 2=good, 3=great
  final String mostConsistentHabit;
  final String weakestDayName;
  final String strongestDayName;

  const AnalyticsData({
    required this.totalCompletions,
    required this.totalStacks,
    required this.overallCompletionRate,
    required this.bestDayStreak,
    required this.weekdayCounts,
    required this.last30DayCounts,
    required this.moodCounts,
    required this.mostConsistentHabit,
    required this.weakestDayName,
    required this.strongestDayName,
  });
}

final analyticsProvider = FutureProvider<AnalyticsData>((ref) async {
  final isar = await ref.read(isarProvider.future);

  final logs = await isar.completionLogs.where().findAll();
  final stacks = await isar.habitStacks
      .filter()
      .isActiveEqualTo(true)
      .findAll();

  if (logs.isEmpty) {
    return AnalyticsData(
      totalCompletions: 0,
      totalStacks: stacks.length,
      overallCompletionRate: 0,
      bestDayStreak: 0,
      weekdayCounts: List.filled(7, 0),
      last30DayCounts: List.filled(30, 0),
      moodCounts: {1: 0, 2: 0, 3: 0},
      mostConsistentHabit: '-',
      weakestDayName: '-',
      strongestDayName: '-',
    );
  }

  // Weekday counts (0=Mon, 6=Sun)
  final weekdayCounts = List<int>.filled(7, 0);
  for (final log in logs) {
    weekdayCounts[log.completedAt.weekday - 1]++;
  }

  // Last 30 days counts
  final today = DateTime.now();
  final start = DateTime(today.year, today.month, today.day)
      .subtract(const Duration(days: 29));
  final last30 = List<int>.filled(30, 0);
  for (final log in logs) {
    final logDay = DateTime(
        log.completedAt.year, log.completedAt.month, log.completedAt.day);
    final diff = logDay.difference(start).inDays;
    if (diff >= 0 && diff < 30) last30[diff]++;
  }

  // Mood distribution
  final moodCounts = <int, int>{1: 0, 2: 0, 3: 0};
  for (final log in logs) {
    if (log.moodScore > 0) {
      moodCounts[log.moodScore] = (moodCounts[log.moodScore] ?? 0) + 1;
    }
  }

  // Overall completion rate (last 30 days)
  final activeDays = last30.where((c) => c > 0).length;
  final completionRate = (activeDays / 30) * 100;

  // Weakest and strongest day names
  const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  int minIndex = 0, maxIndex = 0;
  for (int i = 1; i < 7; i++) {
    if (weekdayCounts[i] < weekdayCounts[minIndex]) minIndex = i;
    if (weekdayCounts[i] > weekdayCounts[maxIndex]) maxIndex = i;
  }

  // Most consistent habit
  final stackCompletions = <String, int>{};
  for (final log in logs) {
    stackCompletions[log.stackUid] =
        (stackCompletions[log.stackUid] ?? 0) + 1;
  }
  String mostConsistentHabit = '-';
  if (stackCompletions.isNotEmpty) {
    final topUid = stackCompletions.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
    final topStack = stacks.firstWhere(
      (s) => s.uid == topUid,
      orElse: () => stacks.first,
    );
    mostConsistentHabit = topStack.newHabit;
  }

  // Best day streak (unique days with at least 1 completion)
  final uniqueDays = logs
      .map((l) => DateTime(
          l.completedAt.year, l.completedAt.month, l.completedAt.day))
      .toSet()
      .toList()
    ..sort();

  int bestStreak = 0, tempStreak = 1;
  for (int i = 1; i < uniqueDays.length; i++) {
    if (uniqueDays[i].difference(uniqueDays[i - 1]).inDays == 1) {
      tempStreak++;
      if (tempStreak > bestStreak) bestStreak = tempStreak;
    } else {
      tempStreak = 1;
    }
  }
  if (bestStreak == 0 && uniqueDays.isNotEmpty) bestStreak = 1;

  return AnalyticsData(
    totalCompletions: logs.length,
    totalStacks: stacks.length,
    overallCompletionRate: completionRate,
    bestDayStreak: bestStreak,
    weekdayCounts: weekdayCounts,
    last30DayCounts: last30,
    moodCounts: moodCounts,
    mostConsistentHabit: mostConsistentHabit,
    weakestDayName: weekdayCounts[minIndex] == 0 ? '-' : dayNames[minIndex],
    strongestDayName: weekdayCounts[maxIndex] == 0 ? '-' : dayNames[maxIndex],
  );
});
