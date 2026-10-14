// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:smartmart_retail_inventory/main.dart';

void main() {
  testWidgets('App loads and displays title and FAB', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const RetailInventoryApp());
    await tester.pumpAndSettle();

    // Verify the app title
    expect(find.text('SmartMart Retailers'), findsOneWidget);

    // Verify the floating action button is present
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Verify we see either sample products or empty state
    final sampleProductFinder = find.text('Coca-Cola 2L');
    final emptyFinder = find.text('No products available');

    expect(
      sampleProductFinder.evaluate().isNotEmpty || emptyFinder.evaluate().isNotEmpty,
      isTrue,
      reason: 'Should show either sample products or empty state message',
    );
  });

  testWidgets('Tapping FAB navigates to add product screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const RetailInventoryApp());
    await tester.pumpAndSettle();

    // Tap the FAB
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify we navigate to the add product screen
    expect(find.text('Add Product'), findsOneWidget);
    expect(find.text('Edit Product'), findsNothing);
  });
}