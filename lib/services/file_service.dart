import 'dart:io';
import '../models/product.dart';

class FileService {
  // Get the application's local directory
  static Future<File> getFile() async {
    final file = File("${Directory.current.path}/data/products.txt");

    return file;
  }

  // Read products from products.txt
  static Future<List<Product>> loadProducts() async {
    final file = await getFile();

// Check if the file exists, if not create it and return an empty list
    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }

// Check if the file exists, if not create it and return an empty list
    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }

    if (!await file.exists()) {
      await file.create();
      return [];
    }

    String contents = await file.readAsString();

    if (contents.trim().isEmpty) {
      return [];
    }

    List<String> lines = contents.split('\n');

    List<Product> products = [];

    for (String line in lines) {
      line = line.trim();

      if (line.isNotEmpty) {
        try {
          products.add(Product.fromFileString(line));
        } catch (e) {
          print('Could not read product: $line');
        }
      }
    }

    return products;
  }

  // Save all products to products.txt
  static Future<void> saveProducts(List<Product> products) async {
    final file = await getFile();

    String contents = '';

    for (Product product in products) {
      contents += '${product.toFileString()}\n';
    }

    await file.writeAsString(contents);
  }
}