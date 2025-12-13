import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:tp_smartshop/widgets/MyAppBar.dart';
import 'package:tp_smartshop/widgets/Categories.dart';
import 'package:tp_smartshop/widgets/ProductTile.dart';
import 'package:tp_smartshop/widgets/SectionTitle.dart';
import 'package:tp_smartshop/Log.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCategory;
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  // 🔥 Lire JSON depuis assets
  Future<void> loadProducts() async {
    final jsonString = await rootBundle.loadString("assets/products.json");
    final jsonData = jsonDecode(jsonString);

    setState(() {
      products = List<Map<String, dynamic>>.from(jsonData);
    });
  }

  // Filtrage par catégorie
  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == null) return products;

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
        child: products.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(title: "Categories"),
                  const SizedBox(height: 16),

                  CategoriesWidget(
                    onCategorySelected: (category) {
                      setState(() {
                        selectedCategory = category;
                        Log.actions.add("Category selected : $category");
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SectionTitle(title: "Products"),
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
                    child: ListView.builder(
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
