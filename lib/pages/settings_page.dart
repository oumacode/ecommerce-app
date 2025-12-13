import 'package:flutter/material.dart';
import 'package:tp_smartshop/pages/prefs_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDark = false;
  double textSize = 16.0;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> saveTheme(bool dark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme_dark', dark);
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prefs.getBool('theme_dark') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 👤 SECTION PRÉFÉRENCES UTILISATEUR
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 12, left: 8),
            child: Text(
              'Mon Compte',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.teal,
              ),
            ),
          ),

          // BOUTON VERS PREFERENCES
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.settings, color: Colors.teal),
              ),
              title: const Text(
                'Préférences personnelles',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: const Text('Nom, mode sombre, panier...'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrefsPage()),
                );
              },
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 🎨 SECTION APPARE
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 12, left: 8),
            child: Text(
              'Apparence',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.teal,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // TAILLE TEXTE
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.text_fields, color: Colors.teal),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Taille du texte",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${textSize.round()} sp",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Slider(
                    value: textSize,
                    min: 12,
                    max: 24,
                    divisions: 12,
                    label: "${textSize.round()} sp",
                    activeColor: Colors.teal,
                    inactiveColor: Colors.grey[300],
                    onChanged: (v) => setState(() => textSize = v),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ℹ️ SECTION À PROPOS
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 12, left: 8),
            child: Text(
              'À propos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.teal,
              ),
            ),
          ),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                ListTile(
                  leading: Icon(Icons.info, color: Colors.teal),
                  title: Text("Version"),
                  subtitle: Text("SmartShop v1.0.0"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}