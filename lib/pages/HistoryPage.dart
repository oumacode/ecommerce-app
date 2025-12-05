import 'package:flutter/material.dart';
import 'package:tp_smartshop/widgets/MyAppBar.dart';
import 'package:tp_smartshop/Log.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(myTitle: "History"),
      body: ListView.builder(
        itemCount: Log.actions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(Log.actions[index]),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  Log.actions.removeAt(index);
                });
              },
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Log.actions.clear();
          });
        },
        child: Icon(Icons.delete_forever),
      ),
    );
  }
}
