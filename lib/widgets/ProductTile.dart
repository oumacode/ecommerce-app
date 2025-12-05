import 'package:flutter/material.dart';

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
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        Container(child: Image.asset(imagePath, height: 80, width: 80)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            SizedBox(height: 4),
            Text(price),
          ],
        ),
        Spacer(),
        Icon(Icons.favorite),
      ],
    ),
  );
  }
}
