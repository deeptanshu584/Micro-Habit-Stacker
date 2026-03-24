import 'package:isar/isar.dart';

part 'habit_stack.g.dart';

@collection
class HabitStack {
  Id id = Isar.autoIncrement;

  late String uid;           // unique string id
  late String triggerHabit;  // \"After I pour my coffee\"
  late String newHabit;      // \"I will write 3 gratitudes\"
  late String emoji;         // \"?\"
  late String category;      // \"Morning\", \"Work\", \"Night\", \"Fitness\", \"Other\"
  late int colorIndex;       // index into our warm color palette
  late DateTime createdAt;
  late int reminderHour;     // 0-23, -1 means no reminder
  late int reminderMinute;
  late bool isActive;
  late bool streakFreezeEnabled;
  late int order;            // for drag-drop reordering
}
