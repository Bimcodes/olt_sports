import 'package:flutter/material.dart';

import '../../../widgets/product_card.dart';
import 'product_details_screen.dart';

class ProductListScreen extends StatelessWidget {
  final String title;

  const ProductListScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 24,
          childAspectRatio: 0.65, // Adjust for product card height
        ),
        itemCount: 8, // Dummy count
        itemBuilder: (context, index) {
          final isEven = index % 2 == 0;
          return ProductCard(
            title: isEven ? 'Portugal' : 'Nigeria',
            category: 'Male',
            priceString: '₦0,000',
            inStock: isEven, // Alternate stock status
            imagePath: '',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductDetailsScreen()),
              );
            },
          );
        },
      ),
    );
  }
}
