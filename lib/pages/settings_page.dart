import 'package:flutter/material.dart';
import 'package:tp_smartshop/pages/prefs_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // BOUTON PRÉFÉRENCES
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Préférences'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrefsPage()),
              );
            },
          ),

          const Divider(),

          // À PROPOS
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('Version'),
            subtitle: Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}