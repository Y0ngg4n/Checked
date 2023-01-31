import 'package:checked/collections/task.dart';
import 'package:checked/utils/date_time_utils.dart';
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

enum AlarmType { before, dateTime, atStartDate, atDeadline }

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

class _TaskEditorState extends State<TaskEditor> with DateTimeUtils {
  final _formKey = GlobalKey<FormState>();
  final maxStepsPrioritySlider = 5;
  String name = "";
  String description = "";
  DateTime? deadline;
  List<DateTimeReminder> dateTimeReminders = [];
  int priority = 1;
  double prioritySlider = 0;
  List<SubTask> subTasks = [];
  DateTime? estimation;
  DateTime? spent;
  DateTime? recurringStartDate;
  DateTime? recurringNext;
  bool recurring = false;
  int recurringIntervalCount = 1;
  StartDateReminder startDateReminder = StartDateReminder();
  DeadlineDateReminder deadlineDateReminder = DeadlineDateReminder();
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
      dateTimeReminders = widget.task!.dateTimeReminders.toList(growable: true);
      priority = widget.task!.priority;
      subTasks = widget.task!.subTasks.toList(growable: true);
      estimation = widget.task!.estimation;
      spent = widget.task!.spent;
      recurring = widget.task!.recurring;
      interval = widget.task!.interval;
      recurringIntervalCount = widget.task!.recurringIntervalCount;
      recurringStartDate = widget.task!.recurringStartDate;
      startDateReminder = widget.task!.startDateReminder;
      deadlineDateReminder = widget.task!.deadlineDateReminder;
      recurringNext = widget.task!.recurringNext;
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
    recurringStartDateController.text = recurringStartDate != null
        ? buildDateTimeText(recurringStartDate!)
        : "";

    WidgetsFlutterBinding.ensureInitialized()
        .scheduleFrameCallback((timeStamp) {
      _mapIntervals();
    });
    startDateReminder.notificationId ??= UniqueKey().hashCode;
    deadlineDateReminder.notificationId ??= UniqueKey().hashCode;
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

  bool _checkReminders(
      DateTimeReminder reminder, List<DateTimeReminder> removeList) {
    if (!_checkReminder(reminder.dateTime!)) {
      removeList.add(reminder);
      return false;
    }
    return true;
  }

  _removeReminders(List<DateTimeReminder> removeList) {
    for (DateTimeReminder removeItem in removeList) {
      dateTimeReminders.remove(removeItem);
    }
  }

  _save() async {
    await _createNotifications();
    await _saveIsar();
  }

  // TODO: Update Notifications when checked
  _createNotifications() async {
    // DateTime Reminders
    List<DateTimeReminder> removeList = [];
    for (DateTimeReminder reminder in dateTimeReminders) {
      _checkReminders(reminder, removeList);
    }
    _removeReminders(removeList);
    NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(taskChannel, taskChannel,
            channelDescription: 'Checked: One Time Event Notification'));
    for (DateTimeReminder reminder in dateTimeReminders) {
      await widget.flutterLocalNotificationsPlugin.zonedSchedule(
          reminder.notificationId!,
          name,
          description,
          tz.TZDateTime.from(reminder.dateTime!, tz.local),
          notificationDetails,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }

    if (recurring && startDateReminder.enabled) {
      if (recurringIntervalCount == 1) {
        if (interval != RecurringInterval.minute &&
            interval != RecurringInterval.hour) {
          DateTimeComponents dateTimeComponent = DateTimeComponents.time;
          switch (interval) {
            case RecurringInterval.day:
              dateTimeComponent = DateTimeComponents.time;
              break;
            case RecurringInterval.week:
              dateTimeComponent = DateTimeComponents.dayOfWeekAndTime;
              break;
            case RecurringInterval.month:
              dateTimeComponent = DateTimeComponents.dayOfMonthAndTime;
              break;
            case RecurringInterval.year:
              dateTimeComponent = DateTimeComponents.dateAndTime;
              break;
            default:
              dateTimeComponent = DateTimeComponents.time;
              break;
          }

          await widget.flutterLocalNotificationsPlugin.zonedSchedule(
              startDateReminder.notificationId!,
              name,
              description,
              tz.TZDateTime.from(recurringStartDate!, tz.local),
              notificationDetails,
              androidAllowWhileIdle: true,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime,
              matchDateTimeComponents: dateTimeComponent);
        } else {
          RepeatInterval repeatInterval = RepeatInterval.hourly;
          switch (interval) {
            case (RecurringInterval.minute):
              repeatInterval = RepeatInterval.everyMinute;
              break;
            case (RecurringInterval.hour):
              repeatInterval = RepeatInterval.hourly;
              break;
            default:
              break;
          }
          await widget.flutterLocalNotificationsPlugin.periodicallyShow(
              startDateReminder.notificationId!,
              name,
              description,
              repeatInterval,
              notificationDetails);
        }
      }
    }
  }

  _cancelNotification(int id) async {
    await widget.flutterLocalNotificationsPlugin.cancel(id);
  }

  _saveIsar() async {
    Task task = widget.task ??
        Task(
            name: name,
            description: description,
            dateTimeReminders: dateTimeReminders,
            created: DateTime.now(),
            edited: DateTime.now(),
            deadline: deadline,
            priority: priority,
            recurringDays: RecurringDays(),
            subTasks: subTasks);
    recurringNext =
        calculateNextDate(recurringNext ?? recurringStartDate, interval, false);
    task
      ..name = name
      ..description = description
      ..dateTimeReminders = dateTimeReminders
      ..deadline = deadline
      ..edited = DateTime.now()
      ..priority = priority
      ..estimation = estimation
      ..spent = spent
      ..subTasks = subTasks
      ..recurring = recurring
      ..recurringStartDate = recurringStartDate
      ..recurringNext = recurringNext
      ..recurringIntervalCount = recurringIntervalCount
      ..startDateReminder = startDateReminder
      ..deadlineDateReminder = deadlineDateReminder
      ..interval = interval;
    Isar? isar = Isar.getInstance("Task");
    isar ??= await Isar.open([TaskSchema], name: "Task");
    await isar.writeTxn(() async {
      await isar!.tasks.put(task); // insert & update
      widget.refresh();
    });
  }

  Future<AlarmType> _askAlarmType() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
                onPressed: () => Navigator.pop(context, AlarmType.before),
                child: Text(AppLocalizations.of(context).bevoreEvent)),
            if (recurring)
              SimpleDialogOption(
                  onPressed: () =>
                      Navigator.pop(context, AlarmType.atStartDate),
                  child: Text(AppLocalizations.of(context).startDate)),
            SimpleDialogOption(
                onPressed: () => Navigator.pop(context, AlarmType.dateTime),
                child: Text(AppLocalizations.of(context).specificDateTime)),
          ],
        );
      },
    );
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
    List<Widget> reminderWidgets = dateTimeReminders
        .map((e) => ListTile(
              leading: const Icon(Icons.alarm),
              title: Text(buildDateTimeText(e.dateTime!)),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    dateTimeReminders.remove(e);
                    _cancelNotification(e.notificationId!);
                  });
                },
              ),
            ))
        .toList();
    if (startDateReminder.enabled) {
      reminderWidgets.add(ListTile(
        leading: const Icon(Icons.alarm),
        title: Text(AppLocalizations.of(context).startDate),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            setState(() {
              startDateReminder.enabled = false;
              _cancelNotification(startDateReminder.notificationId!);
            });
          },
        ),
      ));
    }
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
                        dateTimeReminders.add(DateTimeReminder()
                          ..notificationId = UniqueKey().hashCode
                          ..dateTime =
                              response.subtract(const Duration(hours: 1)));
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
                              AlarmType alarmType = await _askAlarmType();
                              switch (alarmType) {
                                case AlarmType.dateTime:
                                  DateTime? response = await _askDateTime();
                                  if (response != null) {
                                    setState(() {
                                      dateTimeReminders.add(DateTimeReminder()
                                        ..notificationId = UniqueKey().hashCode
                                        ..dateTime = response);
                                    });
                                  }
                                  break;
                                case AlarmType.before:
                                  // TODO: Handle this case.
                                  break;
                                case AlarmType.atStartDate:
                                  setState(() {
                                    startDateReminder.enabled = true;
                                  });
                                  // TODO: Handle this case.
                                  break;
                                case AlarmType.atDeadline:
                                  // TODO: Handle this case.
                                  break;
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
                                        child: Text(intervalNameMapping[item] ??
                                            "Empty")),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    interval = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: !(interval == RecurringInterval.minute ||
                            interval == RecurringInterval.hour),
                        child: Padding(
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
                              if (recurring &&
                                  (value == null || value.isEmpty)) {
                                return AppLocalizations.of(context)
                                    .pleaseEnterSomething;
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
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: TextFormField(
                      //     readOnly: false,
                      //     keyboardType: TextInputType.number,
                      //     controller: recurringIntervalCounterController,
                      //     decoration: InputDecoration(
                      //       suffixIcon: const Icon(Icons.date_range),
                      //       labelText:
                      //           AppLocalizations.of(context).intervalSpace,
                      //       border: const OutlineInputBorder(),
                      //     ),
                      //     validator: (value) {
                      //       if (value == null || int.tryParse(value!) == null) {
                      //         return AppLocalizations.of(context)
                      //             .pleaseEnterSomething;
                      //       }
                      //     },
                      //     onSaved: (String? value) {
                      //       setState(() {
                      //         recurringIntervalCount = int.parse(value!);
                      //       });
                      //     },
                      //   ),
                      // ),
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

  int _rangedSelectedValue(double value) {
    double stepRange = 1.0 / maxStepsPrioritySlider;
    return (value / stepRange + 1).clamp(1, maxStepsPrioritySlider).toInt();
  }
}
