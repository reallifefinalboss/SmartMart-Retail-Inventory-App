import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

const _productsKey = 'smartmart.products';

Future<List<Product>> loadProducts() async {
  final preferences = await SharedPreferences.getInstance();
  var contents = preferences.getString(_productsKey);

  if (contents == null) {
    contents = await rootBundle.loadString('data/products.txt');
    await preferences.setString(_productsKey, contents);
  }

  final products = <Product>[];
  for (final line in contents.split('\n')) {
    final trimmedLine = line.trim();
    if (trimmedLine.isEmpty) {
      continue;
    }

    try {
      products.add(Product.fromFileString(trimmedLine));
    } catch (_) {
      // Ignore malformed records and keep loading valid products.
    }
  }

  return products;
}

Future<void> saveProducts(List<Product> products) async {
  final preferences = await SharedPreferences.getInstance();
  final contents = products.map((product) => product.toFileString()).join('\n');
  await preferences.setString(_productsKey, contents);
}