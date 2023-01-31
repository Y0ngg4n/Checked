import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  String name;
  String description;
  List<DateTimeReminder> dateTimeReminders;
  int priority;
  List<SubTask> subTasks;
  DateTime? estimation;
  DateTime? spent;
  DateTime edited;
  DateTime created;
  DateTime? deadline;
  bool recurring = false;
  DateTime? recurringNext;
  RecurringDays recurringDays;
  int recurringIntervalCount = 1;
  @enumerated
  RecurringInterval interval = RecurringInterval.week;
  DateTime? recurringStartDate;
  StartDateReminder startDateReminder = StartDateReminder();
  DeadlineDateReminder deadlineDateReminder = DeadlineDateReminder();
  bool checked = false;

  Task({
    required this.name,
    required this.description,
    required this.dateTimeReminders,
    required this.created,
    required this.priority,
    required this.subTasks,
    required this.recurringDays,
    required this.edited,
    this.deadline,
    this.estimation,
    this.spent,
  });
}

@embedded
class SubTask {
  String? name;
  bool checked = false;
}

@embedded
class RecurringDays {
  bool recurringMonday = false;
  bool recurringTuesday = false;
  bool recurringWednesday = false;
  bool recurringThursday = false;
  bool recurringFriday = false;
  bool recurringSaturday = false;
  bool recurringSunday = false;
}

enum RecurringInterval {
  minute(1),
  hour(2),
  day(3),
  week(4),
  month(5),
  year(6);

  const RecurringInterval(this.interval);

  final short interval;
}

@embedded
class DateTimeReminder {
  DateTime? dateTime;
  int? notificationId;
}

@embedded
class StartDateReminder {
  bool enabled = false;
  int? notificationId;
}

@embedded
class DeadlineDateReminder {
  bool enabled = false;
  int? notificationId;
}
