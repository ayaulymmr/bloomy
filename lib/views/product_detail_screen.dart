import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(product.imageUrl, height: 200),
            const SizedBox(height: 16),
            Text(product.description),
            const SizedBox(height: 16),
            Text('\$${product.price}', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
