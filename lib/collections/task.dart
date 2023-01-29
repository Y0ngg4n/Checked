import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  String name;
  String description;
  List<DateTime> reminders;
  int priority;
  List<SubTask> subTasks;
  DateTime? estimation;
  DateTime? spent;
  DateTime edited;
  DateTime created;
  DateTime? deadline;
  bool checked = false;

  Task(
      {required this.name,
      required this.description,
      required this.reminders,
      required this.created,
      required this.priority,
      required this.subTasks,
      required this.edited,
      this.deadline,
      this.estimation,
      this.spent});
}

@embedded
class SubTask {
  String? name;
  bool checked = false;
}
