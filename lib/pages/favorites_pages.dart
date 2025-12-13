import 'package:flutter/material.dart';
import 'package:tp_smartshop/services/db_service.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final data = await DBService.getFavorites();
    setState(() {
      favorites = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mes Favoris")),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final item = favorites[index];

          return ListTile(
            title: Text(item["name"]),
            subtitle: Text("Prix : ${item["price"]} DH"),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await DBService.deleteFavorite(item["id"]);
                loadFavorites();
              },
            ),
          );
        },
      ),
    );
  }
}
