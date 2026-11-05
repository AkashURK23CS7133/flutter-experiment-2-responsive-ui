// Experiment 2: Adaptive and Responsive UI Design
// E-Commerce Product Catalog - ShopEasy
import 'package:flutter/material.dart';

void main() {
  runApp(const ShopEasyApp());
}

class ShopEasyApp extends StatelessWidget {
  const ShopEasyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopEasy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        useMaterial3: true,
      ),
      home: const ProductCatalogPage(),
    );
  }
}

class Product {
  final String name;
  final String category;
  final String price;
  final double rating;
  final IconData icon;

  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.icon,
  });
}

const List<Product> products = [
  Product(name: 'Laptop Pro', category: 'Electronics', price: '\$1,299.00', rating: 4.8, icon: Icons.laptop_mac),
  Product(name: 'Smartphone', category: 'Electronics', price: '\$799.00', rating: 4.7, icon: Icons.smartphone),
  Product(name: 'Headphones', category: 'Accessories', price: '\$149.00', rating: 4.6, icon: Icons.headphones),
  Product(name: 'Smart Watch', category: 'Accessories', price: '\$199.00', rating: 4.5, icon: Icons.watch),
  Product(name: 'Camera', category: 'Electronics', price: '\$899.00', rating: 4.8, icon: Icons.camera_alt),
  Product(name: 'Sneakers', category: 'Fashion', price: '\$129.00', rating: 4.4, icon: Icons.directions_run),
  Product(name: 'Backpack', category: 'Fashion', price: '\$79.00', rating: 4.3, icon: Icons.backpack),
  Product(name: 'Tablet', category: 'Electronics', price: '\$599.00', rating: 4.8, icon: Icons.tablet_mac),
];

/// Number of grid columns for a given available width.
/// Mobile (< 600) = 2, Tablet (600–899) = 3, Desktop (>= 900) = 4.
int columnsForWidth(double width) => width < 600
    ? 2
    : width < 900
        ? 3
        : 4;

String layoutNameForWidth(double width) => width < 600
    ? 'Mobile'
    : width < 900
        ? 'Tablet'
        : 'Desktop';

class ProductCatalogPage extends StatefulWidget {
  const ProductCatalogPage({super.key});

  @override
  State<ProductCatalogPage> createState() => _ProductCatalogPageState();
}

class _ProductCatalogPageState extends State<ProductCatalogPage> {
  String selectedCategory = 'All';
  String searchText = '';
  int cartCount = 0;

  List<Product> get filteredProducts {
    return products.where((product) {
      final categoryMatch =
          selectedCategory == 'All' || product.category == selectedCategory;
      final searchMatch =
          product.name.toLowerCase().contains(searchText.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  void addToCart(Product product) {
    setState(() => cartCount++);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${product.name} added to cart'),
          duration: const Duration(seconds: 1),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final visible = filteredProducts;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        title: const Text('ShopEasy', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Row(
              children: [
                const Icon(Icons.shopping_cart_outlined),
                const SizedBox(width: 4),
                Text('Cart ($cartCount)'),
              ],
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final columns = columnsForWidth(width);

          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Discover Products',
                            style: TextStyle(
                              fontSize: width < 600 ? 20 : 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1B5E20),
                            ),
                          ),
                        ),
                        // Shows which responsive layout is active.
                        Chip(
                          avatar: const Icon(Icons.grid_view, size: 16),
                          label: Text(
                              '${layoutNameForWidth(width)} • $columns columns'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text('Quality products at great prices',
                        style: TextStyle(color: Colors.black54)),
                    const SizedBox(height: 12),
                    TextField(
                      onChanged: (value) => setState(() => searchText = value),
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: const Color(0xFFF7F7F7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: ['All', 'Electronics', 'Fashion', 'Accessories']
                            .map(
                              (category) => Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ChoiceChip(
                                  label: Text(category),
                                  selected: selectedCategory == category,
                                  selectedColor: const Color(0xFF2E7D32),
                                  labelStyle: TextStyle(
                                    color: selectedCategory == category
                                        ? Colors.white
                                        : const Color(0xFF1B5E20),
                                  ),
                                  onSelected: (_) =>
                                      setState(() => selectedCategory = category),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: visible.isEmpty
                    ? const Center(child: Text('No products found'))
                    : GridView.builder(
                        padding: EdgeInsets.all(width < 600 ? 12 : 20),
                        itemCount: visible.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: width < 600 ? 0.72 : 0.82,
                        ),
                        itemBuilder: (context, index) {
                          final product = visible[index];
                          return ProductCard(
                            product: product,
                            onAddToCart: () => addToCart(product),
                          );
                        },
                      ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: const Color(0xFF2E7D32),
                child: const Text(
                  'Flutter Lab Experiment 2 • Adaptive & Responsive UI',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Reusable custom product widget.
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(product.icon, size: 54, color: const Color(0xFF2E7D32)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(product.category,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF00695C))),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Text(product.price,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                ),
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: 2),
                Text(product.rating.toString(), style: const TextStyle(fontSize: 11)),
              ],
            ),
            const SizedBox(height: 7),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onAddToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                ),
                child: const Text('Add to Cart', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
