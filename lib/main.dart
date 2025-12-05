import 'package:flutter/material.dart';
import 'package:tp_smartshop/pages/MainScreen.dart';
import 'pages/HomePage.dart';

void main() {
  runApp(const SmartShop());
}

class SmartShop extends StatelessWidget {
  const SmartShop({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SmartShop",
      theme: ThemeData(primarySwatch: Colors.teal, fontFamily: "Poppins"),
      debugShowCheckedModeBanner: false, 
      home: const MainScreen(),
    );
  }
}
