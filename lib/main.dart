// main.dart
import 'package:flutter/material.dart';
import 'screens/product_list_screen.dart';

void main() {
  runApp(const RetailInventoryApp());
}

class RetailInventoryApp extends StatelessWidget {
  const RetailInventoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartMart Retailers',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const ProductListScreen(),
    );
  }
}