import 'package:checked/collections/one_time.dart';
import 'package:checked/navigation.dart';
import 'package:checked/pages/editors/one_time_editor.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OneTimePage extends StatefulWidget {
  final NavigationController navigationController;

  OneTimePage({Key? key, required this.navigationController}) : super(key: key);

  @override
  State<OneTimePage> createState() => _OneTimePageState();
}

class _OneTimePageState extends State<OneTimePage> {
  Isar? isar;
  List<OneTime> data = [];

  @override
  void initState() {
    super.initState();
    widget.navigationController.onFABPressedOneTime = onFABPressed;
    _loadData();
  }

  void onFABPressed() {
    print("On Fab pressed");
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OneTimeEditor(
              refresh: () {
                setState(() {
                  _loadData();
                });
              },
            )));
  }

  Future<void> _loadData() async {
    print("Load Data");
    isar = Isar.getInstance("OneTime");
    isar ??= await Isar.open([OneTimeSchema], name: "OneTime");
    List<OneTime> response = await isar!.oneTimes.where().findAll();
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
    for (OneTime oneTime in data) {
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
            await isar!.oneTimes.delete(oneTime.id);
          });
        },
        key: UniqueKey(),
        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: oneTime.checked,
          onChanged: (value) async {
            oneTime.checked = !oneTime.checked;
            await isar!.writeTxn(() async {
              await isar!.oneTimes.put(oneTime); // delete
            });
            setState(() {
              _sort();
            });
          },
          title: Text(
            oneTime.name ?? "",
            style: oneTime.checked
                ? TextStyle(
                    decoration: TextDecoration.lineThrough,
                  )
                : TextStyle(),
          ),
          subtitle: Text(
            oneTime.description ?? "",
            style: oneTime.checked
                ? TextStyle(
                    decoration: TextDecoration.lineThrough,
                  )
                : TextStyle(),
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
