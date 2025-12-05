import 'package:flutter/material.dart';
import 'package:tp_smartshop/widgets/MyAppBar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> liste_produits = ["Laptop", "SmartWatch", "SmartPhone"];
  List<String> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = [...liste_produits]; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(myTitle: "Search"),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: _filterProducts,
              decoration: InputDecoration(
                labelText: "Rechercher un produit",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  void _filterProducts(String input) {
    setState(() {
      if (input.isEmpty) {
        filteredList = [...liste_produits];
      } else {
        filteredList = liste_produits
            .where((p) => p.toLowerCase().contains(input.toLowerCase()))
            .toList();
      }
    });
  }

  Widget _buildList() {
    if (filteredList == null || filteredList.isEmpty) {
      return const Center(
        child: Text(
          "Aucun produit trouvé",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredList[index]),
        );
      },
    );
  }
}