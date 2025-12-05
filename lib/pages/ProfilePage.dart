import 'package:flutter/material.dart';
import 'package:tp_smartshop/widgets/MyAppBar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(myTitle: "Profile"),
      body: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/logo.png'),
          ),
          SizedBox(height: 20),
          Text("Oumayma Maili", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Etudiante ENIAD"),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("oumaymamaili@gmail.com"),
          ),
          ListTile(leading: Icon(Icons.phone), title: Text("066666663637")),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text("Oujda, Maroc"),
          ),
        ],
      ),
    );
  }
}
