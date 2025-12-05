import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // États locaux pour les paramètres
  bool _darkMode = false;
  double _textSize = 16.0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Apparence
            _buildSectionTitle('Apparence'),
            _buildSettingTile(
              icon: Icons.dark_mode,
              title: 'Mode sombre',
              trailing: Switch(
                value: _darkMode,
                onChanged: (value) {
                  setState(() {
                    _darkMode = value;
                  });
                },
                activeColor: Colors.teal,
              ),
            ),
            
            _buildSettingTile(
              icon: Icons.text_fields,
              title: 'Taille du texte',
              subtitle: '${_textSize.toInt()} sp',
              trailing: SizedBox(
                width: 150,
                child: Slider(
                  value: _textSize,
                  min: 12.0,
                  max: 24.0,
                  divisions: 12,
                  label: '${_textSize.toInt()} sp',
                  onChanged: (value) {
                    setState(() {
                      _textSize = value;
                    });
                  },
                  activeColor: Colors.teal,
                ),
              ),
            ),
            
            const Divider(height: 20, thickness: 1),
            
            
            // Section: A propos
            _buildSectionTitle('À propos'),
            _buildSettingTile(
              icon: Icons.info,
              title: 'Version',
              subtitle: '1.0.0',
            ),
  
          ],
        ),
      ),
    );
  }

  // Méthode pour créer un titre de section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0, left: 8.0),
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

  // Méthode pour créer un élément de paramètre
  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            )
          : null,
      trailing: trailing,
      onTap: onTap,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    );
  }
  }