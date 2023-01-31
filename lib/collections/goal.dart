import 'package:isar/isar.dart';

part 'goal.g.dart';

@collection
class Goal {
  Id id = Isar.autoIncrement;
  String name;
  int dailyPoints;
  Goal(this.name, this.dailyPoints);
}