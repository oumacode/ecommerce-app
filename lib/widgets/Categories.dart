import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  final Function(String?)? onCategorySelected;
  
  const CategoriesWidget({
    super.key,
    this.onCategorySelected,
  });
  
  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final List<String> liste_categories = [
    "Phones", "Laptop", "Watch", "Gaming", "Accessoires"
  ];
  
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: liste_categories.asMap().entries.map((entry) {
          int index = entry.key;
          String category = entry.value;

          return GestureDetector(
            onTap: () {
              setState(() {
                if (selectedIndex == index) {
                  selectedIndex = null; // Deselect
                } else {
                  selectedIndex = index; // Select new category
                }
              });
              
              // Notify parent about the selected category
              if (widget.onCategorySelected != null) {
                widget.onCategorySelected!(
                  selectedIndex == null ? null : category
                );
              }
            },

            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: selectedIndex == index ? Colors.teal : Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: selectedIndex == index ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}