import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../models/completion_log.dart';
import 'isar_provider.dart';

final todayCompletionsProvider = StreamProvider<Set<String>>((ref) {
  final isarAsync = ref.watch(isarProvider);
  return isarAsync.when(
    data: (isar) {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      return isar.completionLogs
          .filter()
          .completedAtBetween(startOfDay, endOfDay)
          .watch(fireImmediately: true)
          .map((logs) => logs.map((l) => l.stackUid).toSet());
    },
    loading: () => const Stream.empty(),
    error: (_, __) => const Stream.empty(),
  );
});

class CompletionNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> markComplete(String stackUid, int moodScore) async {
    final isar = await ref.read(isarProvider.future);
    final log = CompletionLog()
      ..stackUid = stackUid
      ..completedAt = DateTime.now()
      ..moodScore = moodScore;
    await isar.writeTxn(() => isar.completionLogs.put(log));
  }

  Future<void> undoComplete(String stackUid) async {
    final isar = await ref.read(isarProvider.future);
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final log = await isar.completionLogs
        .filter()
        .stackUidEqualTo(stackUid)
        .completedAtGreaterThan(startOfDay)
        .findFirst();
    if (log != null) {
      await isar.writeTxn(() => isar.completionLogs.delete(log.id));
    }
  }
}

final completionNotifierProvider =
    AsyncNotifierProvider<CompletionNotifier, void>(CompletionNotifier.new);
