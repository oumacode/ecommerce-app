import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsPage extends StatefulWidget {
  const PrefsPage({super.key});

  @override
  State<PrefsPage> createState() => _PrefsPageState();
}

class _PrefsPageState extends State<PrefsPage> {
  String username = "";
  bool isDark = false;
  int cartCount = 0;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username") ?? "";
      isDark = prefs.getBool("darkmode") ?? false;
      cartCount = prefs.getInt("cart") ?? 0;
    });
  }

  // Future<void> savePrefs() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString("username", username);
  //   prefs.setBool("darkmode", isDark);
  //   prefs.setInt("cart", cartCount);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My preferences")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Le nom d'utilisateur: $username"),
            Text("Mode: $isDark"),
            Text("Cart Count: $cartCount"),
          ],
        ),
      ),
    );
  }
}
