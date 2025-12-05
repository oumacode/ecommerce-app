import 'package:flutter/material.dart';
import 'package:tp_smartshop/widgets/ProductCard.dart';

class Bottomsheet extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;
  final String category;
  
  const Bottomsheet({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBottomSheet(context);
    });
    
    return Container(); 
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
              Text("hello"),
                ProductCard(
                  name: name,
                  price: price,
                  imagePath: imagePath,
                  category: category,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}