import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartmart_retail_inventory/main.dart' as app;
import 'package:smartmart_retail_inventory/models/product.dart';
import 'package:smartmart_retail_inventory/screens/product_list_screen.dart';
import 'package:smartmart_retail_inventory/screens/product_detail_screen.dart';
import 'package:smartmart_retail_inventory/screens/add_edit_product_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Sample products for testing
  final sampleProducts = [
    Product(
      productCode: 'PRD001',
      productName: 'Coca-Cola 2L',
      category: 'Beverages',
      price: 24.99,
      quantity: 35,
      image: 'assets/images/products/coca_cola.jpg',
      status: 'Available',
    ),
    Product(
      productCode: 'PRD002',
      productName: 'White Bread',
      category: 'Bakery',
      price: 18.50,
      quantity: 12,
      image: 'assets/images/products/bread.jpg',
      status: 'Available',
    ),
    Product(
      productCode: 'PRD003',
      productName: 'Fresh Milk 2L',
      category: 'Dairy',
      price: 32.99,
      quantity: 4,
      image: 'assets/images/products/milk.jpg',
      status: 'Low Stock',
    ),
    Product(
      productCode: 'PRD004',
      productName: 'Washing Powder 2kg',
      category: 'Household',
      price: 79.99,
      quantity: 0,
      image: 'assets/images/products/washing_powder.jpg',
      status: 'Out of Stock',
    ),
    Product(
      productCode: 'PRD005',
      productName: 'USB Keyboard',
      category: 'Electronics',
      price: 199.99,
      quantity: 8,
      image: 'assets/images/products/keyboard.jpg',
      status: 'Available',
    ),
  ];

  Future<void> saveScreenshot(WidgetTester tester, String name) async {
    final screenshotsDir = Directory('screenshots');
    if (!screenshotsDir.existsSync()) {
      screenshotsDir.createSync(recursive: true);
    }

    final renderObject = tester.renderObject<RenderRepaintBoundary>(
      find.byType(RepaintBoundary).first,
    );
    final image = await renderObject.toImage(pixelRatio: 2.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final file = File('screenshots/$name.png');
    await file.writeAsBytes(byteData!.buffer.asUint8List());
    print('Saved screenshot: screenshots/$name.png');
  }

  testWidgets('Product List Screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ProductListScreen(),
    ));
    await tester.pumpAndSettle();

    await saveScreenshot(tester, '01_product_list');
  });

  testWidgets('Product Detail Screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ProductDetailScreen(product: sampleProducts[0]),
    ));
    await tester.pumpAndSettle();

    await saveScreenshot(tester, '02_product_detail');
  });

  testWidgets('Add Product Screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddEditProductScreen(),
    ));
    await tester.pumpAndSettle();

    await saveScreenshot(tester, '03_add_product');
  });

  testWidgets('Edit Product Screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AddEditProductScreen(product: sampleProducts[0]),
    ));
    await tester.pumpAndSettle();

    await saveScreenshot(tester, '04_edit_product');
  });

  testWidgets('Product List - Hide IDs', (WidgetTester tester) async {
    // We can't easily test the toggle without the full app state
    // Just capture the default state (IDs shown)
    await tester.pumpWidget(MaterialApp(
      home: ProductListScreen(),
    ));
    await tester.pumpAndSettle();

    await saveScreenshot(tester, '05_product_list_show_ids');
  });
}