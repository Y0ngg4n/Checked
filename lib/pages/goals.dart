import 'package:checked/collections/goal.dart';
import 'package:checked/navigation.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'editors/goal_editor.dart';

class Goals extends StatefulWidget {
  NavigationController navigationController;

  Goals({Key? key, required this.navigationController}) : super(key: key);

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  Isar? isar;
  List<Goal> data = [];

  @override
  void initState() {
    super.initState();
    widget.navigationController.onFABPressedGoals = onFABPressed;
    _loadData();
  }

  Future<void> _loadData() async {
    print("Load Data");
    isar = Isar.getInstance("Goal");
    isar ??= await Isar.open([GoalSchema], name: "Goal");
    List<Goal> response = await isar!.goals.where().findAll();
    setState(() {
      data = response;
    });
  }

  void onFABPressed() {
    print("On Fab pressed");
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => GoalEditor(
              refresh: () {
                setState(() {
                  _loadData();
                });
              },
            )));
  }

  Widget getSubtitleCard(String title, int count) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 1, 0),
            child: Icon(Icons.track_changes),
          ),
          Text("$title:"),
          Text(count.toString())
        ],
      ),
    ));
  }

  Widget getGoalListTile(Goal goal) {
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
        await isar!.writeTxn(() async {
          await isar!.goals.delete(goal.id);
        });
      },
      key: UniqueKey(),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GoalEditor(
                    goal: goal,
                    refresh: () {
                      setState(() {
                        _loadData();
                      });
                    },
                  )));
        },
        title: Text(goal.name),
        subtitle: Row(
          children: [
            getSubtitleCard(
                AppLocalizations.of(context).daily, goal.dailyPoints),
            getSubtitleCard(
                AppLocalizations.of(context).monthly, goal.weeklyPoints),
            getSubtitleCard(
                AppLocalizations.of(context).weekly, goal.monthlyPoints),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [for (Goal goal in data) getGoalListTile(goal)],
    );
  }
}
