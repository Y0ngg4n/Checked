import 'dart:ffi';

import 'package:checked/collections/goal.dart';
import 'package:checked/collections/task.dart';
import 'package:checked/collections/task_history.dart';
import 'package:checked/navigation.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'editors/goal_editor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Goals extends StatefulWidget {
  NavigationController navigationController;

  Goals({Key? key, required this.navigationController}) : super(key: key);

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  Isar? isar;
  List<Goal> data = [];
  List<TaskHistory> history = [];

  @override
  void initState() {
    super.initState();
    widget.navigationController.onFABPressedGoals = onFABPressed;
    _loadData();
  }

  Future<void> _loadData() async {
    print("Load Data");
    isar = Isar.getInstance();
    isar ??= await Isar.open([TaskSchema, TaskHistorySchema, GoalSchema]);
    List<Goal> response = await isar!.goals.where().findAll();
    List<TaskHistory> historyResponse =
        await isar!.taskHistorys.where().findAll();
    setState(() {
      data = response;
      history = historyResponse;
    });
  }

  void onFABPressed() async {
    print("On Fab pressed");
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => GoalEditor()));
    await _loadData();
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
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GoalEditor(
                    goal: goal,
                  )));
          await _loadData();
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
    List<CircularGoalChartData> daily = [];
    for (TaskHistory taskHistory in history) {
      DateTime now = DateTime.now();
      DateTime nowDay = DateTime(now.year, now.month, now.day);
      // Check today
      if (taskHistory.dateTime == nowDay) {
        print("Leas"  + taskHistory.tasks.length.toString());
        for (Task task in taskHistory.tasks) {
          List<GoalPoints> goalPoints = task.goals.toList();
          print("for" + goalPoints.length.toString());
          print("dadfs" + task.goals.length.toString());
          Map<Goal, int> mapGoalPoints = {};
          for (GoalPoints goalPoint in goalPoints) {
            Goal goal =
                data.firstWhere((element) => element.id == goalPoint.id);
            if (mapGoalPoints.containsKey(goal)) {
              print(goalPoint.points);
              mapGoalPoints[goal] = mapGoalPoints[goal]! + goalPoint.points!;
            } else {
              mapGoalPoints[goal] = goalPoint.points!;
            }
          }
          for (Goal goal in mapGoalPoints.keys) {
            print("Map goal points" + mapGoalPoints[goal]!.toString());
            daily.add(
                CircularGoalChartData(x: goal.name, y: mapGoalPoints[goal]!));
          }
        }
      }
    }
    return ListView(
      children: [
        Column(
          children: [
            SfCircularChart(
                legend: Legend(isVisible: true),
                title: ChartTitle(text: "Goals today"),
                series: <CircularSeries>[
                  RadialBarSeries<CircularGoalChartData, String>(
                      dataSource: daily,
                      xValueMapper: (CircularGoalChartData data, _) {
                        print(data.x);
                        return data.x;
                      },
                      yValueMapper: (CircularGoalChartData data, _) {
                        print(data.y);
                        return data.y;
                      }),
                ]),
          ],
        ),
        Column(
          children: [for (Goal goal in data) getGoalListTile(goal)],
        )
      ],
    );
  }
}

class CircularGoalChartData {
  String x = "Test";
  int y = 1;

  CircularGoalChartData({required this.x, required this.y});
}
