// screens/product_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/file_service.dart';
import 'add_edit_product_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Future<void> deleteProduct() async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: Text(
            'Are you sure you want to delete '
            '${widget.product.productName}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      List<Product> products = await FileService.loadProducts();

      products.removeWhere(
        (product) =>
            product.productCode == widget.product.productCode,
      );

      await FileService.saveProducts(products);

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Product product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage(product.image),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      product.productName,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Divider(),

                    buildDetailRow(
                      'Product Code',
                      product.productCode,
                    ),

                    buildDetailRow(
                      'Category',
                      product.category,
                    ),

                    buildDetailRow(
                      'Unit Price',
                      'R${product.price.toStringAsFixed(2)}',
                    ),

                    buildDetailRow(
                      'Quantity',
                      product.quantity.toString(),
                    ),

                    buildDetailRow(
                      'Status',
                      product.status,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddEditProductScreen(
                            product: product,
                          ),
                        ),
                      );

                      setState(() {});
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: deleteProduct,
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}