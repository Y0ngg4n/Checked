import 'package:checked/collections/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gradient_colored_slider/gradient_colored_slider.dart';
import 'package:isar/isar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const String taskChannel = "pro.obco.checked/task";
const List<Color> gradientColors = [
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.red
];

class TaskEditor extends StatefulWidget {
  Function refresh;
  Task? task;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  TaskEditor({
    Key? key,
    required this.refresh,
    required this.flutterLocalNotificationsPlugin,
    this.task,
  }) : super(key: key);

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  final _formKey = GlobalKey<FormState>();
  final maxStepsPrioritySlider = 5;
  String name = "";
  String description = "";
  DateTime? deadline;
  List<DateTime> reminders = [];
  int priority = 1;
  double prioritySlider = 0;
  List<SubTask> subTasks = [];
  DateTime? estimation;
  DateTime? spent;
  DateTime? recurringStartDate;
  bool recurring = false;
  int recurringIntervalCount = 1;
  RecurringInterval interval = RecurringInterval.week;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController spentTimeController = TextEditingController();
  TextEditingController estimateTimeController = TextEditingController();
  TextEditingController recurringStartDateController = TextEditingController();
  TextEditingController recurringIntervalCounterController =
      TextEditingController();
  Map<RecurringInterval, String> intervalNameMapping = {};

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();

    if (widget.task != null) {
      name = widget.task!.name;
      description = widget.task!.description;
      deadline = widget.task!.deadline;
      reminders = widget.task!.reminders;
      priority = widget.task!.priority;
      subTasks = widget.task!.subTasks.toList(growable: true);
      estimation = widget.task!.estimation;
      spent = widget.task!.spent;
      recurring = widget.task!.recurring;
      recurringIntervalCount = widget.task!.recurringIntervalCount;
      recurringStartDate = widget.task!.recurringStartDate;
    }
    nameController.text = name;
    descriptionController.text = description;
    deadlineController.text =
        deadline != null ? buildDateTimeText(deadline!) : "";
    estimateTimeController.text =
        estimation != null ? "${estimation!.hour}h ${estimation!.minute}m" : "";
    spentTimeController.text =
        spent != null ? "${spent!.hour}h ${spent!.minute}m" : "";
    prioritySlider = (1 / (maxStepsPrioritySlider - 1)) * (priority - 1);
    recurringIntervalCounterController.text = recurringIntervalCount.toString();

    WidgetsFlutterBinding.ensureInitialized()
        .scheduleFrameCallback((timeStamp) {
      _mapIntervals();
    });
  }

  _mapIntervals() {
    setState(() {
      intervalNameMapping = {
        RecurringInterval.minute: AppLocalizations.of(context).minutely,
        RecurringInterval.hour: AppLocalizations.of(context).hourly,
        RecurringInterval.day: AppLocalizations.of(context).daily,
        RecurringInterval.week: AppLocalizations.of(context).weekly,
        RecurringInterval.month: AppLocalizations.of(context).monthly,
        RecurringInterval.year: AppLocalizations.of(context).yearly,
      };
    });
  }

  bool _checkReminder(DateTime reminder) {
    if (reminder.isBefore(DateTime.now())) {
      return false;
    }
    return true;
  }

  bool _checkReminders(DateTime reminder, List<DateTime> removeList) {
    if (!_checkReminder(reminder)) {
      removeList.add(reminder);
      return false;
    }
    return true;
  }

  _removeReminders(List<DateTime> removeList) {
    for (DateTime removeItem in removeList) {
      reminders.remove(removeItem);
    }
  }

  _save() async {
    await _createNotifications();
    await _saveIsar();
  }

  _createNotifications() async {
    List<DateTime> removeList = [];
    for (DateTime reminder in reminders) {
      _checkReminders(reminder, removeList);
    }
    _removeReminders(removeList);
    for (DateTime reminder in reminders) {
      await widget.flutterLocalNotificationsPlugin.zonedSchedule(
          UniqueKey().hashCode,
          name,
          description,
          tz.TZDateTime.from(reminder, tz.local),
          const NotificationDetails(
              android: AndroidNotificationDetails(taskChannel, taskChannel,
                  channelDescription: 'Checked: One Time Event Notification')),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  _saveIsar() async {
    Task task = widget.task ??
        Task(
            name: name,
            description: description,
            reminders: reminders,
            created: DateTime.now(),
            edited: DateTime.now(),
            deadline: deadline,
            priority: priority,
            recurringDays: RecurringDays(),
            subTasks: subTasks);
    task
      ..name = name
      ..description = description
      ..reminders = reminders
      ..deadline = deadline
      ..edited = DateTime.now()
      ..priority = priority
      ..estimation = estimation
      ..spent = spent
      ..subTasks = subTasks
      ..recurring = recurring
      ..recurringStartDate = recurringStartDate
      ..recurringIntervalCount = recurringIntervalCount
      ..interval = interval;
    Isar? isar = Isar.getInstance("Task");
    isar ??= await Isar.open([TaskSchema], name: "Task");
    await isar.writeTxn(() async {
      await isar!.tasks.put(task); // insert & update
      widget.refresh();
    });
  }

  Future<DateTime?> _askDateTime() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        lastDate: DateTimeMaxMin.max,
        firstDate: DateTime.now());
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(minutes: 1))),
    );
    if (date != null && time != null) {
      DateTime build =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
      if (_checkReminder(build)) {
        return build;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).invalidInput)));
        return null;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).invalidInput)));
      return null;
    }
  }

  Future<TimeOfDay?> _askTime() async {
    return await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay.fromDateTime(DateTime(DateTime.now().year, 0, 0, 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> reminderWidgets = reminders
        .map((e) => ListTile(
              leading: const Icon(Icons.alarm),
              title: Text(buildDateTimeText(e)),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    reminders.remove(e);
                  });
                },
              ),
            ))
        .toList();
    List<Widget> subTaskWidgets = subTasks.map((e) {
      return ListTile(
          leading: Checkbox(
            value: e.checked,
            onChanged: (value) {
              setState(() {
                e.checked = !e.checked;
              });
            },
          ),
          title: TextFormField(
            initialValue: e.name ?? "",
            onChanged: (String value) {
              setState(() {
                e.name = value;
              });
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                subTasks.remove(e);
              });
            },
          ));
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).one_time),
      ),
      body: Form(
        key: _formKey,
        child: Stack(children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.abc),
                      labelText: AppLocalizations.of(context).name,
                      border: const OutlineInputBorder()),
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context).pleaseEnterSomething;
                    }
                    _formKey.currentState!.save();
                    return null;
                  },
                  onSaved: (String? value) {
                    setState(() {
                      name = value ?? "";
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.abc),
                    labelText: AppLocalizations.of(context).description,
                    border: const OutlineInputBorder(),
                  ),
                  onSaved: (String? value) {
                    setState(() {
                      description = value ?? "";
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  controller: deadlineController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.date_range),
                    labelText: AppLocalizations.of(context).deadline,
                    border: const OutlineInputBorder(),
                  ),
                  onTap: () async {
                    DateTime? response = await _askDateTime();
                    if (response != null) {
                      setState(() {
                        deadline = response;
                        reminders
                            .add(response.subtract(const Duration(hours: 1)));
                      });
                      deadlineController.text = buildDateTimeText(response);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Text("${AppLocalizations.of(context).priority}:"),
                  ),
                  Expanded(
                    child: GradientColoredSlider(
                      value: prioritySlider.toDouble(),
                      gradientColors: gradientColors,
                      barWidth: 10,
                      barSpace: 5,
                      onChanged: (double value) {
                        setState(() {
                          prioritySlider = value;
                          priority = _rangedSelectedValue(prioritySlider);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child:
                        Text(_rangedSelectedValue(prioritySlider).toString()),
                  )
                ]),
              ),
              Card(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context).alarms,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    Column(
                      children: reminderWidgets,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).backgroundColor),
                        child: IconButton(
                            onPressed: () async {
                              DateTime? response = await _askDateTime();
                              if (response != null) {
                                setState(() {
                                  reminders.add(response);
                                });
                              }
                            },
                            icon: const Icon(Icons.add)),
                      ),
                    ),
                  ],
                ),
              ),
              CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(AppLocalizations.of(context).recurring),
                  value: recurring,
                  onChanged: (value) {
                    setState(() {
                      recurring = !recurring;
                    });
                  }),
              Visibility(
                visible: recurring,
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: recurringStartDateController,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.date_range),
                            labelText: AppLocalizations.of(context).startDate,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (recurring && (value == null || value.isEmpty)) {
                              return AppLocalizations.of(context).pleaseEnterSomething;
                            }
                            return null;
                          },
                          onTap: () async {
                            DateTime? response = await _askDateTime();
                            if (response != null) {
                              setState(() {
                                recurringStartDate = response;
                              });
                              recurringStartDateController.text =
                                  buildDateTimeText(response);
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          readOnly: false,
                          keyboardType: TextInputType.number,
                          controller: recurringIntervalCounterController,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.date_range),
                            labelText:
                                AppLocalizations.of(context).intervalSpace,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || int.tryParse(value!) == null) {
                              return AppLocalizations.of(context)
                                  .pleaseEnterSomething;
                            }
                          },
                          onSaved: (String? value) {
                            setState(() {
                              recurringIntervalCount = int.parse(value!);
                            });
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context).interval,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                                value: interval,
                                items: [
                                  for (RecurringInterval item
                                      in RecurringInterval.values)
                                    DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                            intervalNameMapping[item] ?? "")),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    interval = value!;
                                  });
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context).subTask,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Column(
                        children: subTaskWidgets,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).backgroundColor),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                print("Add subtask");
                                subTasks.add(SubTask());
                              });
                            },
                            icon: const Icon(Icons.add)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  controller: estimateTimeController,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.abc),
                      labelText: AppLocalizations.of(context).timeEstimation,
                      border: const OutlineInputBorder()),
                  validator: (String? text) {
                    _formKey.currentState!.save();
                    return null;
                  },
                  onTap: () async {
                    TimeOfDay? response = await _askTime();
                    if (response != null) {
                      setState(() {
                        estimation = DateTime(DateTime.now().year, 0, 0,
                            response.hour, response.minute);

                        estimateTimeController.text =
                            "${response.hour}h ${response.minute}m";
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(AppLocalizations.of(context).invalidInput)));
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  controller: spentTimeController,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.abc),
                      labelText: AppLocalizations.of(context).spentTime,
                      border: const OutlineInputBorder()),
                  validator: (String? text) {
                    _formKey.currentState!.save();
                    return null;
                  },
                  onTap: () async {
                    TimeOfDay? response = await _askTime();
                    if (response != null) {
                      setState(() {
                        spent = DateTime(DateTime.now().year, 0, 0,
                            response.hour, response.minute);

                        spentTimeController.text =
                            "${response.hour}h ${response.minute}m";
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(AppLocalizations.of(context).invalidInput)));
                    }
                  },
                ),
              ),
              SizedBox(
                height: 58,
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _save();
                      Navigator.pop(context);
                    }
                  },
                  child: const Icon(
                    Icons.save,
                  )),
            ),
          ),
        ]),
      ),
    );
  }

  String buildDateTimeText(DateTime dateTime) {
    return "${dateTime.day}.${dateTime.month}.${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
  }

  int _rangedSelectedValue(double value) {
    double stepRange = 1.0 / maxStepsPrioritySlider;
    return (value / stepRange + 1).clamp(1, maxStepsPrioritySlider).toInt();
  }
}

class DateTimeMaxMin {
  static const _numDays = 100000000;

  static DateTime get min => DateTime.fromMicrosecondsSinceEpoch(0)
      .subtract(const Duration(days: _numDays));

  static DateTime get max => DateTime.fromMicrosecondsSinceEpoch(0)
      .add(const Duration(days: _numDays));
}
