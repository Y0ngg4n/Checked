import 'package:isar/isar.dart';

part 'goal.g.dart';

@collection
class Goal {
  Id id = Isar.autoIncrement;
  String name;
  int dailyPoints;
  int weeklyPoints;
  int monthlyPoints;
  Goal(this.name, this.dailyPoints, this.weeklyPoints, this.monthlyPoints);

  @override
  String toString() => name;

  @override
  operator ==(o) => o is Goal && o.id == id;

  @override
  int get hashCode => id.hashCode^name.hashCode;
}