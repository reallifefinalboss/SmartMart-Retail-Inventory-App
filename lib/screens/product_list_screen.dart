// screens/product_list_screen.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/file_service.dart';
import 'product_detail_screen.dart';
import 'add_edit_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  // Load products from products.txt
  Future<void> loadProducts() async {
    List<Product> loadedProducts = await FileService.loadProducts();

    // Add sample products if the file is empty
    if (loadedProducts.isEmpty) {
      loadedProducts = [
        Product(
          productCode: 'PRD001',
          productName: 'Coca-Cola 2L',
          category: 'Beverages',
          price: 24.99,
          quantity: 35,
          image: 'assets/coca_cola.jpg',
          status: 'Available',
        ),
        Product(
          productCode: 'PRD002',
          productName: 'White Bread',
          category: 'Bakery',
          price: 18.50,
          quantity: 12,
          image: 'assets/bread.jpg',
          status: 'Available',
        ),
        Product(
          productCode: 'PRD003',
          productName: 'Fresh Milk 2L',
          category: 'Dairy',
          price: 32.99,
          quantity: 4,
          image: 'assets/milk.jpg',
          status: 'Low Stock',
        ),
        Product(
          productCode: 'PRD004',
          productName: 'Washing Powder 2kg',
          category: 'Household',
          price: 79.99,
          quantity: 0,
          image: 'assets/washing_powder.jpg',
          status: 'Out of Stock',
        ),
        Product(
          productCode: 'PRD005',
          productName: 'USB Keyboard',
          category: 'Electronics',
          price: 199.99,
          quantity: 8,
          image: 'assets/keyboard.jpg',
          status: 'Available',
        ),
      ];

      await FileService.saveProducts(loadedProducts);
    }

    setState(() {
      products = loadedProducts;
    });
  }

  // Delete a product
  Future<void> deleteProduct(int index) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: Text(
            'Are you sure you want to delete '
            '${products[index].productName}?',
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
      setState(() {
        products.removeAt(index);
      });

      await FileService.saveProducts(products);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartMart Inventory'),
        centerTitle: true,
      ),

      body: products.isEmpty
          ? const Center(
              child: Text(
                'No products available',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(product.image),
                    ),

                    title: Text(
                      product.productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      '${product.productCode}\n'
                      'R${product.price.toStringAsFixed(2)}',
                    ),

                    isThreeLine: true,

                    trailing: Text(
                      product.status,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: getStatusColor(product.status),
                      ),
                    ),

                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            product: product,
                          ),
                        ),
                      );

                      loadProducts();
                    },

                    onLongPress: () {
                      deleteProduct(index);
                    },
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditProductScreen(),
            ),
          );

          loadProducts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Color getStatusColor(String status) {
    if (status == 'Available') {
      return Colors.green;
    } else if (status == 'Low Stock') {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}