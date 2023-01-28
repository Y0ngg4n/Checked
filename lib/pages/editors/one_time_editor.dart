import 'package:checked/collections/one_time.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class OneTimeEditor extends StatefulWidget {
  Function refresh;
  OneTimeEditor({Key? key, required this.refresh}) : super(key: key);

  @override
  State<OneTimeEditor> createState() => _OneTimeEditorState();
}

class _OneTimeEditorState extends State<OneTimeEditor> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String description = "";
  List<DateTime> reminders = [];

  _saveIsar() async {
    OneTime oneTime = OneTime()
      ..name = name
      ..description = description
      ..reminders = reminders;
    Isar? isar = Isar.getInstance("OneTime");
    isar ??= await Isar.open([OneTimeSchema], name: "OneTime");
    await isar.writeTxn(() async {
      await isar!.oneTimes.put(oneTime); // insert & update
      widget.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> reminderWidgets = reminders
        .map((e) => ListTile(
              leading: const Icon(Icons.alarm),
              title: Text("${e.day}.${e.month}.${e.year}"),
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create One-Time"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: "Name", border: OutlineInputBorder()),
                validator: (String? text) {
                  if (text == null || text.isEmpty) {
                    return "Please enter a name";
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                validator: (String? text) {
                  if (text == null || text.isEmpty) {
                    return "Please enter a description";
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
              Expanded(
                child: ListView(
                  children: reminderWidgets,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).backgroundColor),
                child: IconButton(
                    onPressed: () async {
                      DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          lastDate: DateTimeMaxMin.max,
                          firstDate: DateTime.now());
                      TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (date != null && time != null) {
                        setState(() {
                          reminders.add(DateTime(date.year, date.month,
                              date.day, time.hour, time.minute));
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Date or Time are invalid")));
                      }
                    },
                    icon: const Icon(Icons.add)),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.pop(context);
                    }
                    _saveIsar();
                  },
                  child: const Icon(
                    Icons.save,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class DateTimeMaxMin {
  static const _numDays = 100000000;

  static DateTime get min =>
      DateTime.fromMicrosecondsSinceEpoch(0).subtract(Duration(days: _numDays));

  static DateTime get max =>
      DateTime.fromMicrosecondsSinceEpoch(0).add(Duration(days: _numDays));
}