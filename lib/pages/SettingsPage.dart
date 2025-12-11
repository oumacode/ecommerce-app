import 'package:flutter/material.dart';
import 'package:tp_smartshop/pages/prefs_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  double textSize = 16.0;

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
          _sectionTitle('Apparence'),
          _switchTile('Mode sombre', darkMode, Icons.dark_mode, (value) {
            setState(() => darkMode = value);
          }),
          _sliderTile('Taille du texte', textSize, Icons.text_fields, (value) {
            setState(() => textSize = value);
          }),
          const Divider(height: 20),
          
          // Section pour les préférences
          _sectionTitle('Navigation'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  PrefsPage()),
                );
              },
              icon: const Icon(Icons.settings),
              label: const Text('Go to preferences'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
          
          _sectionTitle('À propos'),
          _infoTile('Version', '1.0.0', Icons.info),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12, left: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget _switchTile(String title, bool value, IconData icon, Function(bool) onChanged) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.teal,
      ),
    );
  }

  Widget _sliderTile(String title, double value, IconData icon, Function(double) onChanged) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(title),
      subtitle: Text('${value.round()} sp'),
      trailing: SizedBox(
        width: 150,
        child: Slider(
          value: value,
          min: 12,
          max: 24,
          divisions: 12,
          label: '${value.round()} sp',
          onChanged: onChanged,
          activeColor: Colors.teal,
        ),
      ),
    );
  }

  Widget _infoTile(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}