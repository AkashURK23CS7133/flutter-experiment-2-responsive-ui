import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exp02_responsive_ui/main.dart';

int gridColumns(WidgetTester tester) {
  final grid = tester.widget<GridView>(find.byType(GridView));
  final delegate =
      grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
  return delegate.crossAxisCount;
}

Future<void> pumpAtSize(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const ShopEasyApp());
}

void main() {
  test('column breakpoints', () {
    expect(columnsForWidth(400), 2);
    expect(columnsForWidth(700), 3);
    expect(columnsForWidth(1200), 4);
  });

  testWidgets('Mobile width shows 2 columns', (tester) async {
    await pumpAtSize(tester, const Size(400, 900));
    expect(gridColumns(tester), 2);
  });

  testWidgets('Tablet width shows 3 columns', (tester) async {
    await pumpAtSize(tester, const Size(750, 1000));
    expect(gridColumns(tester), 3);
  });

  testWidgets('Desktop width shows 4 columns', (tester) async {
    await pumpAtSize(tester, const Size(1300, 1000));
    expect(gridColumns(tester), 4);
  });

  testWidgets('Search, category filter and Add to Cart work', (tester) async {
    await pumpAtSize(tester, const Size(1300, 1400));
    expect(find.byType(ProductCard), findsNWidgets(8));

    Finder chip(String label) =>
        find.widgetWithText(ChoiceChip, label);

    await tester.tap(chip('Fashion'));
    await tester.pump();
    expect(find.byType(ProductCard), findsNWidgets(2));
    expect(find.text('Sneakers'), findsOneWidget);

    await tester.tap(chip('All'));
    await tester.enterText(find.byType(TextField), 'cam');
    await tester.pump();
    expect(find.byType(ProductCard), findsOneWidget);

    await tester.tap(find.text('Add to Cart'));
    await tester.pump();
    expect(find.text('Cart (1)'), findsOneWidget);
    expect(find.text('Camera added to cart'), findsOneWidget);
  });
}
