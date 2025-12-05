import 'package:flutter/material.dart';
import 'package:tp_smartshop/pages/SearchPage.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String myTitle;
  const MyAppbar({super.key, required this.myTitle});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(myTitle),
      actions: [
        IconButton(
          onPressed: () { 
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}