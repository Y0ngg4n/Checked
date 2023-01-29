import 'package:checked/collections/task.dart';
import 'package:checked/navigation.dart';
import 'package:checked/pages/editors/task_editor.dart';
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

class _TasksPageState extends State<TasksPage> {
  Isar? isar;
  List<Task> data = [];

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
  }

  _sort() {
    data.sort(((a, b) {
      if (a.checked && !b.checked) {
        return 1;
      } else if (!a.checked && b.checked) {
        return -1;
      } else {
        return a.name!.compareTo(b.name!);
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    for (Task task in data) {
      items.add(Dismissible(
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
          await isar!.writeTxn(() async {
            await isar!.tasks.delete(task.id);
          });
        },
        key: UniqueKey(),
        child: ListTile(
          leading: Checkbox(
            value: task.checked,
            onChanged: (value) async {
              task.checked = !task.checked;
              await isar!.writeTxn(() async {
                await isar!.tasks.put(task); // delete
              });
              setState(() {
                _sort();
              });
            },
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
                  )
                : const TextStyle(),
          ),
          subtitle: Text(
            task.description ?? "",
            style: task.checked
                ? const TextStyle(
                    decoration: TextDecoration.lineThrough,
                  )
                : const TextStyle(),
          ),
        ),
      ));
    }
    if (items.isEmpty) {
      return (Center(child: Text(AppLocalizations.of(context)!.noItems)));
    }
    return ListView(
      children: items,
    );
  }
}