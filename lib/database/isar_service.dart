import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/habit_stack.dart';
import '../models/completion_log.dart';
import '../models/mood_entry.dart';

class IsarService {
  static late Isar _isar;

  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [HabitStackSchema, CompletionLogSchema, MoodEntrySchema],
      directory: dir.path,
    );
    return _isar;
  }

  static Isar get instance => _isar;
}
