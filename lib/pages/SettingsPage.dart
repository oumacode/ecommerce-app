import 'package:flutter/material.dart';
import 'package:tp_smartshop/widgets/MyAppBar.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(myTitle: "Settings"),
      body: Row(
        children: [
        // SwitchTheme(data: data, child: child),
        ],
      ),
    );
  }
}
