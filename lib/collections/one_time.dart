import 'package:isar/isar.dart';

part 'one_time.g.dart';

@collection
class OneTime {
  Id id = Isar.autoIncrement;
  String? name;
  String? description;
  List<DateTime>? reminders;
  bool? checked;
}