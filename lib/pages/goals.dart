import 'package:checked/collections/goal.dart';
import 'package:checked/navigation.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
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

  }

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
