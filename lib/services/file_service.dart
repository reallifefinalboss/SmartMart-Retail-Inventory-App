import 'file_service_stub.dart'
    if (dart.library.io) 'file_service_io.dart'
    if (dart.library.js_interop) 'file_service_web.dart' as storage;
import '../models/product.dart';

class FileService {
  static Future<List<Product>> loadProducts() => storage.loadProducts();

  static Future<void> saveProducts(List<Product> products) =>
      storage.saveProducts(products);
}