import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsPage extends StatefulWidget {
  const PrefsPage({super.key});

  @override
  State<PrefsPage> createState() => _PrefsPageState();
}

class _PrefsPageState extends State<PrefsPage> {
  final TextEditingController nameController = TextEditingController();

  bool darkMode = false;
  int cartCount = 0;

  @override
  void initState() {
    super.initState();
    loadPrefs();
  }

  Future<void> loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      nameController.text = prefs.getString("username") ?? "";
      darkMode = prefs.getBool("darkmode") ?? false;
      cartCount = prefs.getInt("cart") ?? 0;
    });
  }

  Future<void> savePrefs() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("username", nameController.text);
    await prefs.setBool("darkmode", darkMode);
    await prefs.setInt("cart", cartCount);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Préférences sauvegardées")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Préférences utilisateur")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🔤 NOM UTILISATEUR
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nom de l'utilisateur",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // 🌙 MODE SOMBRE (VISUEL)
            SwitchListTile(
              title: const Text("Mode sombre"),
              value: darkMode,
              onChanged: (value) {
                setState(() {
                  darkMode = value;
                });
              },
            ),

            const SizedBox(height: 15),

            // 🛒 PANIER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Articles dans le panier"),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (cartCount > 0) {
                          setState(() => cartCount--);
                        }
                      },
                    ),
                    Text(cartCount.toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() => cartCount++);
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 💾 SAUVEGARDER
            ElevatedButton(
              onPressed: savePrefs,
              child: const Text("Sauvegarder"),
            ),
          ],
        ),
      ),
    );
  }
}