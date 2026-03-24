import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../models/habit_stack.dart';
import 'isar_provider.dart';
import '../core/utils/notification_service.dart';

final habitStacksProvider = StreamProvider<List<HabitStack>>((ref) {
  final isarAsync = ref.watch(isarProvider);
  return isarAsync.when(
    data: (isar) => isar.habitStacks
        .filter()
        .isActiveEqualTo(true)
        .sortByOrder()
        .watch(fireImmediately: true),
    loading: () => const Stream.empty(),
    error: (_, __) => const Stream.empty(),
  );
});

class HabitStackNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> addStack(HabitStack stack) async {
    final isar = await ref.read(isarProvider.future);
    await isar.writeTxn(() => isar.habitStacks.put(stack));

    // Schedule notification if reminder is set
    await NotificationService.scheduleStackReminder(stack);
  }

  Future<void> deleteStack(int id) async {
    final isar = await ref.read(isarProvider.future);

    // Cancel notification before deleting
    final stack = await isar.habitStacks.get(id);
    if (stack != null) {
      await NotificationService.cancelStackReminder(stack);
    }

    await isar.writeTxn(() => isar.habitStacks.delete(id));
  }

  Future<void> updateStack(HabitStack stack) async {
    final isar = await ref.read(isarProvider.future);
    await isar.writeTxn(() => isar.habitStacks.put(stack));

    // Cancel old notification and reschedule with new time
    await NotificationService.cancelStackReminder(stack);
    await NotificationService.scheduleStackReminder(stack);
  }

  Future<void> reorderStacks(List<HabitStack> stacks) async {
    final isar = await ref.read(isarProvider.future);
    await isar.writeTxn(() async {
      for (int i = 0; i < stacks.length; i++) {
        stacks[i].order = i;
        await isar.habitStacks.put(stacks[i]);
      }
    });
  }
}

final habitStackNotifierProvider =
    AsyncNotifierProvider<HabitStackNotifier, void>(HabitStackNotifier.new);
