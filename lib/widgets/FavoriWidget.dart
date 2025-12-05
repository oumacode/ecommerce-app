import 'package:flutter/material.dart';

class FavoriWidget extends StatefulWidget {
  const FavoriWidget({super.key});

  @override
  State<FavoriWidget> createState() => _FavoriWidgetState();
}

class _FavoriWidgetState extends State<FavoriWidget> {
  bool aime = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        aime ? Icons.favorite : Icons.favorite_border,
        color: aime ? Colors.red : Colors.grey,
      ),
      onPressed: () => setState(() => aime = !aime),
    );
  }
}
