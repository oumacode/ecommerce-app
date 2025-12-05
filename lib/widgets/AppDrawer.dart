import 'package:flutter/material.dart';
import 'package:tp_smartshop/pages/HomePage.dart';
import 'package:tp_smartshop/pages/CartPage.dart';
import 'package:tp_smartshop/pages/ProfilePage.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                "SmartShop",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Accueil"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text("Panier"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartPage()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),

            title: Text("Profil"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            ),
          ),
        ],
      ),
    );
  }
}
