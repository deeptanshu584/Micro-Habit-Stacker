import 'package:isar/isar.dart';

part 'completion_log.g.dart';

@collection
class CompletionLog {
  Id id = Isar.autoIncrement;

  late String stackUid;      // links to HabitStack.uid
  late DateTime completedAt;
  late int moodScore;        // 1=meh, 2=good, 3=great, 0=no mood logged
}
