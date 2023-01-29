import 'package:checked/collections/one_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:isar/isar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const String oneTimeChannel = "pro.obco.checked/one_time";

class OneTimeEditor extends StatefulWidget {
  Function refresh;
  OneTime? oneTime;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  OneTimeEditor({
    Key? key,
    required this.refresh,
    required this.flutterLocalNotificationsPlugin,
    this.oneTime,
  }) : super(key: key);

  @override
  State<OneTimeEditor> createState() => _OneTimeEditorState();
}

class _OneTimeEditorState extends State<OneTimeEditor> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String description = "";
  DateTime? deadline;
  List<DateTime> reminders = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();

    if (widget.oneTime != null) {
      name = widget.oneTime!.name;
      description = widget.oneTime!.description;
      deadline = widget.oneTime!.deadline;
      reminders = widget.oneTime!.reminders ?? [];
    }
    nameController.text = name;
    descriptionController.text = description;
    deadlineController.text =
    deadline != null ? buildDateTimeText(deadline!) : "";
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
              android: AndroidNotificationDetails(
                  oneTimeChannel, oneTimeChannel,
                  channelDescription:
                  'Checked: One Time Event Notification')),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  _saveIsar() async {
    OneTime oneTime = widget.oneTime ??
        OneTime(name, description, reminders, DateTime.now(), deadline);
    oneTime
      ..name = name
      ..description = description
      ..reminders = reminders
      ..deadline = deadline;
    Isar? isar = Isar.getInstance("OneTime");
    isar ??= await Isar.open([OneTimeSchema], name: "OneTime");
    await isar.writeTxn(() async {
      await isar!.oneTimes.put(oneTime); // insert & update
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
            SnackBar(content: Text(AppLocalizations
                .of(context)
                .invalidInput)));
        return null;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations
              .of(context)
              .invalidInput)));
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> reminderWidgets = reminders
        .map((e) =>
        ListTile(
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations
            .of(context)
            .one_time),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.abc),
                      labelText: AppLocalizations
                          .of(context)
                          .name,
                      border: const OutlineInputBorder()),
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations
                          .of(context)
                          .pleaseEnterSomething;
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
                    labelText: AppLocalizations
                        .of(context)
                        .description,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations
                          .of(context)
                          .pleaseEnterSomething;
                    }
                    _formKey.currentState!.save();
                    return null;
                  },
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
                    labelText: AppLocalizations
                        .of(context)
                        .deadline,
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations
                        .of(context)
                        .alarms,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineSmall,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Card(
                  child: ListView(
                    children: reminderWidgets,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme
                          .of(context)
                          .backgroundColor),
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
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.pop(context);
                      }
                      _save();
                    },
                    child: const Icon(
                      Icons.save,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String buildDateTimeText(DateTime dateTime) {
    return "${dateTime.day}.${dateTime.month}.${dateTime.year} ${dateTime
        .hour}:${dateTime.minute}";
  }
}

class DateTimeMaxMin {
  static const _numDays = 100000000;

  static DateTime get min =>
      DateTime.fromMicrosecondsSinceEpoch(0)
          .subtract(const Duration(days: _numDays));

  static DateTime get max =>
      DateTime.fromMicrosecondsSinceEpoch(0)
          .add(const Duration(days: _numDays));
}
