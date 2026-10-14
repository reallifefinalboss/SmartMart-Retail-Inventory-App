import '../models/product.dart';

Future<List<Product>> loadProducts() {
  throw UnsupportedError('Product storage is not supported on this platform.');
}

Future<void> saveProducts(List<Product> products) {
  throw UnsupportedError('Product storage is not supported on this platform.');
}