import 'package:flutter/material.dart';
import 'package:tp_smartshop/services/db_service.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> favorites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    setState(() {
      isLoading = true;
    });

    final data = await DbService().getFavorites();

    setState(() {
      favorites = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Favoris"),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : favorites.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        "Aucun favoris",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final item = favorites[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: ListTile(
                        leading: const Icon(Icons.favorite, color: Colors.red),
                        title: Text(
                          item["nom"] ?? "Nom inconnu",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Prix : ${item["price"]} DH"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Supprimer"),
                                content: const Text(
                                  "Voulez-vous vraiment supprimer ce favori ?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    child: const Text("Annuler"),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, true),
                                    child: const Text(
                                      "Supprimer",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await DbService().deleteFavorite(item["id"]);
                              await loadFavorites();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Favori supprimé")),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
