import 'package:checked/collections/task.dart';
import 'package:isar/isar.dart';

part 'task_history.g.dart';

@collection
class TaskHistory {
  Id? id = Isar.autoIncrement;
  @Index(unique: true)
  late DateTime dateTime;
  final tasks = IsarLinks<Task>();
}