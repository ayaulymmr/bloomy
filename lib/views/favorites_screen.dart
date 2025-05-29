import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/product_view_model.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<ProductViewModel>().favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet.'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return ProductCard(product: favorites[index]);
              },
            ),
    );
  }
}
