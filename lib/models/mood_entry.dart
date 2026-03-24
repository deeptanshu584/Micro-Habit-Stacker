import 'package:isar/isar.dart';

part 'mood_entry.g.dart';

@collection
class MoodEntry {
  Id id = Isar.autoIncrement;

  late String stackUid;
  late DateTime date;
  late int moodScore;  // 1, 2, or 3
}
