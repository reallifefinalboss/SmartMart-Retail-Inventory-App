// models/product.dart
class Product {
  String productCode;
  String productName;
  String category;
  double price;
  int quantity;
  String image;
  String status;

  Product({
    required this.productCode,
    required this.productName,
    required this.category,
    required this.price,
    required this.quantity,
    required this.image,
    required this.status,
  });

  // Convert the Product object into one line
  // that can be saved in products.txt
  String toFileString() {
    return '$productCode,$productName,$category,$price,$quantity,$status';
  }

  // Convert one line from products.txt
  // back into a Product object
  static Product fromFileString(String line) {
    List<String> data = line.split(',');

    return Product(
      productCode: data[0],
      productName: data[1],
      category: data[2],
      price: double.parse(data[3]),
      quantity: int.parse(data[4]),
      image: getImageForProduct(data[0]),
      status: data[5],
    );
  }

  // Choose an image based on the product code
  static String getImageForProduct(String code) {
    switch (code) {
      case 'PRD001':
        return 'assets/coca_cola.jpg';

      case 'PRD002':
        return 'assets/bread.jpg';

      case 'PRD003':
        return 'assets/milk.jpg';

      case 'PRD004':
        return 'assets/washing_powder.jpg';

      case 'PRD005':
        return 'assets/keyboard.jpg';

      default:
        return 'assets/default.jpg';
    }
  }
}