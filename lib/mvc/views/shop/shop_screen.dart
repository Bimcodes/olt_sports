import 'package:flutter/material.dart';

import '../../../widgets/product_card.dart';
import '../../../widgets/section_header.dart';
import 'product_details_screen.dart';
import 'product_list_screen.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories and Carousel Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: Categories List
                  const SizedBox(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Unisex',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Female',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Male',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Right: Hero Carousel Image
                  Expanded(
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100, // Placeholder
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(),
                          const Text(
                            'Featured Product Image',
                            style: TextStyle(color: Colors.black54),
                          ),
                          const Spacer(),
                          // Dots indicator
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildDot(isActive: true),
                                _buildDot(isActive: false),
                                _buildDot(isActive: false),
                                _buildDot(isActive: false),
                                _buildDot(isActive: false),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Country Jerseys
            SectionHeader(
              title: 'Country Jerseys',
              onTapViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) =>
                            const ProductListScreen(title: 'Country Jerseys'),
                  ),
                );
              },
            ),
            _buildHorizontalProductList(context, 'Portugal', 'Nigeria'),

            const SizedBox(height: 24),

            // Club Jerseys
            SectionHeader(
              title: 'Club Jerseys',
              onTapViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => const ProductListScreen(title: 'Club Jerseys'),
                  ),
                );
              },
            ),
            _buildHorizontalProductList(context, 'Liverpool', 'Chelsea'),

            const SizedBox(height: 48), // Bottom safe area
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalProductList(
    BuildContext context,
    String p1Title,
    String p2Title,
  ) {
    return SizedBox(
      height: 280,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          SizedBox(
            width: 180,
            child: ProductCard(
              title: p1Title,
              category: 'Male',
              priceString: '₦0,000',
              inStock: true,
              imagePath: '',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProductDetailsScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 180,
            child: ProductCard(
              title: p2Title,
              category: 'Male',
              priceString: '₦0,000',
              inStock: false,
              imagePath: '',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProductDetailsScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 180,
            child: ProductCard(
              title: 'Arsenal',
              category: 'Male',
              priceString: '₦0,000',
              inStock: true,
              imagePath: '',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProductDetailsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF516D54) : Colors.black12,
        shape: BoxShape.circle,
      ),
    );
  }
}
