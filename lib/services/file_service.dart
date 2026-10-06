// services/file_service.dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/product.dart';

class FileService {
  // Get the application's local directory
  static Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/products.txt');

    return file;
  }

  // Read products from products.txt
  static Future<List<Product>> loadProducts() async {
    final file = await getFile();

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