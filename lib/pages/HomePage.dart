import 'package:flutter/material.dart';
import 'package:tp_smartshop/widgets/MyAppBar.dart';
import 'package:tp_smartshop/widgets/Categories.dart';
import 'package:tp_smartshop/widgets/ProductTile.dart';
import 'package:tp_smartshop/widgets/SectionTitle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCategory;
  
  final List<Map<String, dynamic>> products = [
    {
      'name': 'iPhone 15',
      'price': '999€',
      'category': 'Phones',
      'image': 'products/phone.png',
    },
    {
      'name': 'Samsung Galaxy',
      'price': '899€',
      'category': 'Phones',
      'image': 'products/phone.png',
    },
    {
      'name': 'MacBook Pro',
      'price': '1999€',
      'category': 'Laptop',
      'image': 'products/laptop.png',
    },
    {
      'name': 'Dell XPS',
      'price': '1499€',
      'category': 'Laptop',
      'image': 'products/laptop.png',
    },
    {
      'name': 'Apple Watch',
      'price': '399€',
      'category': 'Watch',
      'image': 'products/watch.png',
    },
  ];


  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == null) {
      return products; 
    }
    return products
        .where((product) => product['category'] == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(myTitle: "SmartShop"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: "Catégories"),
            const SizedBox(height: 16),
            CategoriesWidget(
              onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionTitle(title: "Produits"),
                if (selectedCategory != null)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = null;
                      });
                    },
                    child: const Text(
                      "Tout afficher",
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(
                      child: Text(
                        "Aucun produit dans cette catégorie",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return ProductTile(
                          imagePath: product['image'],
                          name: product['name'],
                          price: product['price'],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}