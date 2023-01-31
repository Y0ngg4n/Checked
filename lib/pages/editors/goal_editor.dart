import 'package:checked/collections/goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:isar/isar.dart';

class GoalEditor extends StatefulWidget {
  Function refresh;
  Goal? goal;

  GoalEditor({Key? key, required this.refresh, this.goal}) : super(key: key);

  @override
  State<GoalEditor> createState() => _GoalEditorState();
}

class _GoalEditorState extends State<GoalEditor> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  int dailyPoints = 0;
  int weeklyPoints = 0;
  int monthlyPoints = 0;

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.goal != null) {
      name = widget.goal!.name;
      dailyPoints = widget.goal!.dailyPoints;
      weeklyPoints = widget.goal!.weeklyPoints;
      monthlyPoints = widget.goal!.monthlyPoints;
    }
    nameController.text = name;
  }

  void _save() async {
    Goal goal = Goal(name, dailyPoints, weeklyPoints, monthlyPoints);
    if (widget.goal != null) {
      goal = widget.goal!
        ..name = name
        ..dailyPoints = dailyPoints
        ..weeklyPoints = weeklyPoints
        ..monthlyPoints = monthlyPoints;
    }
    Isar? isar = Isar.getInstance("Goal");
    isar ??= await Isar.open([GoalSchema], name: "Goal");
    await isar.writeTxn(() async {
      await isar!.goals.put(goal);
      widget.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).task),
        ),
        body: Form(
            key: _formKey,
            child: Stack(children: [
              ListView(children: [
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
                        return AppLocalizations.of(context)
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
                _getPointsField(AppLocalizations.of(context).daily,
                    (String? value) {
                  if (value == null || int.tryParse(value) == null) return;
                  setState(() {
                    dailyPoints = int.parse(value);
                  });
                }, dailyPoints.toString()),
                _getPointsField(AppLocalizations.of(context).weekly,
                    (String? value) {
                  if (value == null || int.tryParse(value) == null) return;
                  setState(() {
                    weeklyPoints = int.parse(value);
                  });
                }, weeklyPoints.toString()),
                _getPointsField(AppLocalizations.of(context).monthly,
                    (String? value) {
                  if (value == null || int.tryParse(value) == null) return;
                  setState(() {
                    monthlyPoints = int.parse(value);
                  });
                }, monthlyPoints.toString()),
              ]),
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
            ])));
  }

  _getPointsField(
      String fieldName, Function(String? value) onSaved, String initialValue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.abc),
          labelText: "$fieldName ${AppLocalizations.of(context).points}",
          border: const OutlineInputBorder(),
        ),
        initialValue: initialValue,
        validator: (value) {
          if (value == null || value.isEmpty || int.tryParse(value) == null) {
            return AppLocalizations.of(context).pleaseEnterSomething;
          }
          _formKey.currentState!.save();
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }
}
