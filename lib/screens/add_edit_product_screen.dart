// screens/add_edit_product_screen.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/file_service.dart';

class AddEditProductScreen extends StatefulWidget {
  final Product? product;

  const AddEditProductScreen({
    super.key,
    this.product,
  });

  @override
  State<AddEditProductScreen> createState() =>
      _AddEditProductScreenState();
}

class _AddEditProductScreenState
    extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  String? selectedCategory;
  String? selectedStatus;

  final List<String> categories = [
    'Beverages',
    'Groceries',
    'Bakery',
    'Dairy',
    'Household',
    'Personal Care',
    'Electronics',
    'Other',
  ];

  final List<String> statuses = [
    'Available',
    'Low Stock',
    'Out of Stock',
  ];

  String selectedImage = 'assets/images/products/default.jpg';

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      Product product = widget.product!;

      codeController.text = product.productCode;
      nameController.text = product.productName;
      priceController.text = product.price.toString();
      quantityController.text = product.quantity.toString();

      selectedCategory = product.category;
      selectedStatus = product.status;
      selectedImage = product.image;
    }
  }

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();

    super.dispose();
  }

  Future<void> saveProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    List<Product> products =
        await FileService.loadProducts();

    double price = double.parse(priceController.text);
    int quantity = int.parse(quantityController.text);

    String code = codeController.text.trim();

    // Check for duplicate product code (excluding current product when editing)
    bool codeExists = products.any(
      (product) =>
          product.productCode == code &&
          (widget.product == null || product.productCode != widget.product!.productCode),
    );

    if (codeExists) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Product code already exists.',
          ),
        ),
      );

      return;
    }

    // Auto-determine status based on quantity
    String status = selectedStatus!;
    if (quantity == 0) {
      status = 'Out of Stock';
    } else if (quantity < 5) {
      status = 'Low Stock';
    } else {
      status = 'Available';
    }

    if (widget.product == null) {
      // ADD PRODUCT

      Product newProduct = Product(
        productCode: code,
        productName: nameController.text.trim(),
        category: selectedCategory!,
        price: price,
        quantity: quantity,
        image: selectedImage,
        status: status,
      );

      products.add(newProduct);
    } else {
      // EDIT PRODUCT

      widget.product!.productCode = code;
      widget.product!.productName =
          nameController.text.trim();
      widget.product!.category = selectedCategory!;
      widget.product!.price = price;
      widget.product!.quantity = quantity;
      widget.product!.status = status;
      widget.product!.image = selectedImage;

      int index = products.indexWhere(
        (product) =>
            product.productCode == widget.product!.productCode,
      );

      if (index != -1) {
        products[index] = widget.product!;
      }
    }

    await FileService.saveProducts(products);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.product != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Product' : 'Add Product',
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              TextFormField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: 'Product Code',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter a product code';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter a product name';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                initialValue: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: priceController,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Unit Price',
                  prefixText: 'R ',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter a price';
                  }

                  double? price =
                      double.tryParse(value);

                  if (price == null) {
                    return 'Price must be numeric';
                  }

                  if (price <= 0) {
                    return 'Price must be greater than zero';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantity in Stock',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter quantity';
                  }

                  int? quantity =
                      int.tryParse(value);

                  if (quantity == null) {
                    return 'Quantity must be an integer';
                  }

                  if (quantity < 0) {
                    return 'Quantity cannot be negative';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                initialValue: selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: statuses.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a status';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                initialValue: selectedImage,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Product Image',
                  border: OutlineInputBorder(),
                ),
                items: [
                  'apple.jpg',
                  'bananas.jpg',
                  'bread.jpg',
                  'chicken_breast.jpg',
                  'coca_cola.jpg',
                  'coffee_beans.jpg',
                  'default.jpg',
                  'desk_lamp.jpg',
                  'dish_soap.jpg',
                  'hand_sanitizer.jpg',
                  'keyboard.jpg',
                  'laundry_detergent.jpg',
                  'led_bulb.jpg',
                  'milk.jpg',
                  'notebook.jpg',
                  'orange_juice.jpg',
                  'potato_chips.jpg',
                  'shampoo.jpg',
                  'washing_powder.jpg',
                  'wireless_mouse.jpg',
                  'yogurt.jpg',
                ].map((image) {
                  final assetPath = 'assets/images/products/$image';
                  return DropdownMenuItem(
                    value: assetPath,
                    child: Text(image.replaceAll('.jpg', '').replaceAll('_', ' ')),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedImage = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an image';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              Image.asset(
                selectedImage,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: saveProduct,
                      child: Text(
                        isEditing ? 'Update' : 'Save',
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}