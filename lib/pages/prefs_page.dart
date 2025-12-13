import 'package:flutter/material.dart';
import 'package:tp_smartshop/services/pref_service.dart';

class PrefsPage extends StatefulWidget {
  const PrefsPage({super.key});

  @override
  _PrefsPageState createState() => _PrefsPageState();
}

class _PrefsPageState extends State<PrefsPage> {
  late TextEditingController _usernameController;
  late bool _darkMode;
  late int _cartCount;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
    _usernameController = TextEditingController();
  }

  Future<void> _loadPrefs() async {
    await PrefsService.init(); // S'assurer que PrefsService est initialisé
    setState(() {
      _usernameController.text = PrefsService.getUsername();
      _darkMode = PrefsService.getDarkMode();
      _cartCount = PrefsService.getCartCount();
    });
  }

  Future<void> _savePrefs() async {
    await PrefsService.saveAll(
      username: _usernameController.text.trim(),
      darkMode: _darkMode,
      cartCount: _cartCount,
    );
    
    // Afficher un message de succès
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Préférences sauvegardées !'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _resetPrefs() async {
    await PrefsService.resetAll();
    await _loadPrefs(); // Recharger avec valeurs par défaut
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Préférences réinitialisées !'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Préférences'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👤 NOM D'UTILISATEUR
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nom d\'utilisateur',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Entrez votre nom',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🌙 MODE SOMBRE
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Thème',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SwitchListTile(
                      title: const Text('Mode sombre'),
                      subtitle: const Text('Activer l\'apparence sombre'),
                      value: _darkMode,
                      onChanged: (value) {
                        setState(() {
                          _darkMode = value;
                        });
                      },
                      secondary: Icon(
                        _darkMode ? Icons.dark_mode : Icons.light_mode,
                        color: _darkMode ? Colors.amber : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🛒 NOMBRE D'ARTICLES DANS LE PANIER
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Panier',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.shopping_cart, color: Colors.teal),
                        const SizedBox(width: 10),
                        const Text('Articles dans le panier :'),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (_cartCount > 0) {
                              setState(() => _cartCount--);
                            }
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$_cartCount',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() => _cartCount++);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // 📥 BOUTONS D'ACTION
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _savePrefs,
                    icon: const Icon(Icons.save),
                    label: const Text('Sauvegarder'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _resetPrefs,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Réinitialiser'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}