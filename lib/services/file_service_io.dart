import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/product.dart';

Future<File> _getFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File('${directory.path}/products.txt');
}

Future<List<Product>> loadProducts() async {
  final file = await _getFile();

  if (!await file.parent.exists()) {
    await file.parent.create(recursive: true);
  }

  if (!await file.exists()) {
    await file.create();
    return [];
  }

  final contents = await file.readAsString();
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
  final file = await _getFile();
  final contents = products.map((product) => product.toFileString()).join('\n');
  await file.writeAsString(contents.isEmpty ? '' : '$contents\n');
}