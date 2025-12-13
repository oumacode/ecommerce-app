import 'package:flutter/material.dart';
import 'package:tp_smartshop/widgets/MyAppBar.dart';
import 'package:tp_smartshop/services/db_service.dart';

class ProductPage extends StatefulWidget {
  final String name;
  final String imagePath;
  final String price;

  const ProductPage({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool added = false;

  void _toggleCart() {
    setState(() {
      added = !added;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          added ? "Produit ajouté au panier !" : "Produit retiré du panier",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(myTitle: "Product Details"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(widget.imagePath, height: 180),
            Text(widget.name),
            Text(widget.price),
            const Icon(Icons.star, color: Colors.amber),

            // 🔥 BOUTON FAVORIS CORRIGÉ 🔥
            ElevatedButton(
              onPressed: () async {
                await DBService.addFavorite(
                  widget.name,
                  double.tryParse(widget.price) ?? 0.0,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Ajouté aux favoris !")),
                );
              },
              child: Text("Ajouter aux Favoris"),
            ),

            ElevatedButton(
              onPressed: _toggleCart,
              child: Text(added ? "Retirer du panier" : "Ajouter au panier"),
            ),
          ],
        ),
      ),
    );
  }
}
