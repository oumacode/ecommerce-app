import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({
    super.key,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
    children: [
      Container(child: Text("|"),),
      SizedBox(width: 10),
      Text(title),
    ],);
  }
}
