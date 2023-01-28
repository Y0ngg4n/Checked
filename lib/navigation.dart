import 'package:checked/pages/editors/one_time_editor.dart';
import 'package:checked/pages/one_time.dart';
import 'package:flutter/material.dart';

class NavigationController {
  late void Function() onFABPressedOneTime;
  late void Function() onFABPressedRecurring;
  late void Function() onFABPressedAchievements;
  late void Function() onFABPressedStats;
}

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final NavigationController navigationController = NavigationController();
  int selectedItem = 0;

  void onFABPressed() {
    switch (selectedItem) {
      case 0:
        navigationController.onFABPressedOneTime();
        break;
      case 1:
        navigationController.onFABPressedRecurring();
        break;
      case 2:
        navigationController.onFABPressedAchievements();
        break;
      case 3:
        navigationController.onFABPressedStats();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (selectedItem) {
      case 0:
        body = OneTimePage(
          navigationController: navigationController,
        );
        break;
      default:
        body = Container();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checked"),
      ),
      body: SafeArea(child: body),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => onFABPressed(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor.withAlpha(255),
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
          selectedItemColor: Theme.of(context).colorScheme.onSurface,
          elevation: 0,
          unselectedItemColor: Colors.black,
          currentIndex: selectedItem,
          onTap: (int index) {
            setState(() {
              selectedItem = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.plus_one),
                label: "One-Time",
                backgroundColor: Theme.of(context).backgroundColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.repeat),
                label: "Recurring",
                backgroundColor: Theme.of(context).backgroundColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.military_tech),
                label: "Achievements",
                backgroundColor: Theme.of(context).backgroundColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: "Stats",
                backgroundColor: Theme.of(context).backgroundColor),
          ],
        ),
      ),
    );
  }
}
