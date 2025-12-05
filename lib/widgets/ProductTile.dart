import 'package:flutter/material.dart';
import 'package:tp_smartshop/pages/ProductDetailsPage.dart';
import 'package:tp_smartshop/widgets/FavoriWidget.dart';

class ProductTile extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;
  
  const ProductTile({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showProductDetailsSheet(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 80,
              width: 80,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
              FavoriWidget(),
          ],
        ),
      ),
    );
  }

  void _showProductDetailsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imagePath,
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 20),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Add to Cart'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductPage(imagePath: imagePath, name: name, price: price)));
                    },
                    child: const Text('More details'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}