import 'package:checked/collections/task.dart';
import 'package:checked/navigation.dart';
import 'package:checked/pages/editors/task_editor.dart';
import 'package:checked/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:isar/isar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksPage extends StatefulWidget {
  final NavigationController navigationController;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  TasksPage(
      {Key? key,
      required this.navigationController,
      required this.flutterLocalNotificationsPlugin})
      : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with DateTimeUtils {
  Isar? isar;
  List<Task> data = [];
  bool showChecked = false;
  Map<Task, bool> subTasksVisible = {};

  @override
  void initState() {
    super.initState();
    widget.navigationController.onFABPressedTasks = onFABPressed;
    _loadData();
  }

  void onFABPressed() {
    print("On Fab pressed");
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TaskEditor(
              flutterLocalNotificationsPlugin:
                  widget.flutterLocalNotificationsPlugin,
              refresh: () {
                setState(() {
                  _loadData();
                });
              },
            )));
  }

  Future<void> _loadData() async {
    print("Load Data");
    isar = Isar.getInstance("Task");
    isar ??= await Isar.open([TaskSchema], name: "Task");
    List<Task> response = await isar!.tasks.where().findAll();
    _sort();
    setState(() {
      data = response;
    });
    _subTaskMapping();
  }

  _sort() {
    data.sort(((a, b) {
      if (a.checked && !b.checked) {
        return 1;
      } else if (!a.checked && b.checked) {
        return -1;
      } else {
        return a.name.compareTo(b.name);
      }
    }));
  }

  _subTaskMapping() {
    for (Task task in data) {
      subTasksVisible.putIfAbsent(task, () => false);
    }
  }

  _getListTile(Task task) {
    List<Widget> subTasks = [];
    for (SubTask subTask in task.subTasks) {
      subTasks.add(Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: subTask.checked,
          onChanged: (value) async {
            subTask.checked = !subTask.checked;
            await isar!.writeTxn(() async {
              await isar!.tasks.put(task); // delete
            });
            setState(() {
              _sort();
            });
          },
          title: Text(subTask.name ?? ""),
        ),
      ));
    }
    return Dismissible(
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      onDismissed: (DismissDirection dismissDirection) async {
        for (DateTimeReminder dateTimeReminder in task.dateTimeReminders) {
          await widget.flutterLocalNotificationsPlugin
              .cancel(dateTimeReminder.notificationId!);
        }
        await widget.flutterLocalNotificationsPlugin
            .cancel(task.startDateReminder.notificationId!);
        await widget.flutterLocalNotificationsPlugin
            .cancel(task.deadlineDateReminder.notificationId!);
        await isar!.writeTxn(() async {
          await isar!.tasks.delete(task.id);
        });
      },
      key: UniqueKey(),
      child: Container(
        color: gradientColors[task.priority - 1].withAlpha(100),
        child: Column(
          children: [
            ListTile(
              leading: Checkbox(
                value: task.checked,
                onChanged: (value) async {
                  if (!task.recurring) task.checked = !task.checked;
                  task.recurringNext = calculateNextDate(
                      task.recurringNext, task.interval, true);
                  await isar!.writeTxn(() async {
                    await isar!.tasks.put(task); // delete
                  });
                  setState(() {
                    _sort();
                  });
                },
              ),
              trailing: Visibility(
                visible: subTasks.isNotEmpty,
                child: IconButton(
                  icon: subTasksVisible[task]!
                      ? const Icon(Icons.expand_less)
                      : const Icon(Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      subTasksVisible[task] = !subTasksVisible[task]!;
                    });
                  },
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TaskEditor(
                          flutterLocalNotificationsPlugin:
                              widget.flutterLocalNotificationsPlugin,
                          refresh: () {
                            setState(() {
                              _loadData();
                            });
                          },
                          task: task,
                        )));
              },
              title: Text(
                task.name ?? "",
                style: task.checked
                    ? const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.bold)
                    : const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: [
                  Visibility(
                    visible: task.recurringNext != null,
                    child: Card(
                        color: task.recurringNext != null
                            ? (task.recurringNext!.isBefore(DateTime.now())
                                ? Colors.red
                                : null)
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 1, 0),
                                child: Icon(Icons.repeat),
                              ),
                              Text(task.recurringNext != null
                                  ? buildDateTimeText(task.recurringNext!)
                                  : ""),
                            ],
                          ),
                        )),
                  ),
                  Visibility(
                    visible: task.deadline != null,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 1, 0),
                              child: Icon(Icons.cancel_schedule_send),
                            ),
                            Text(
                              (task.deadline != null
                                  ? "${task.deadline!.day}.${task.deadline!.month}.${task.deadline!.year} ${task.deadline!.hour}:${task.deadline!.minute}"
                                  : ""),
                              style: task.checked
                                  ? const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                    )
                                  : const TextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: task.description.isNotEmpty,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
                        child: Text(
                          (task.description ?? ""),
                          style: task.checked
                              ? const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                )
                              : const TextStyle(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
                visible: subTasksVisible[task]!,
                child: Column(
                    children: [for (Widget subTask in subTasks) subTask])),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    for (Task task in data.where((element) => !element.checked)) {
      items.add(_getListTile(task));
    }
    List<Widget> checkedItems = [];
    for (Task task in data.where((element) => element.checked)) {
      checkedItems.add(_getListTile(task));
    }
    if (items.isEmpty && checkedItems.isEmpty) {
      return (Center(child: Text(AppLocalizations.of(context).noItems)));
    }
    return ListView(
      children: [
        Column(
          children: items,
        ),
        ExpansionTile(
          title: Text(AppLocalizations.of(context).checkedTasks),
          children: checkedItems,
        ),
      ],
    );
  }
}
