import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/mock_data_service.dart';

class ProductViewModel extends ChangeNotifier {
  final List<Product> _products = MockDataService.getMockProducts();
  final List<Product> _favorites = [];

  List<Product> get products => _products;
  List<Product> get favorites => _favorites;

  void toggleFavorite(Product product) {
    product.isFavorite = !product.isFavorite;

    if (product.isFavorite) {
      _favorites.add(product);
    } else {
      _favorites.removeWhere((p) => p.id == product.id);
    }

    notifyListeners();
  }

  bool isFavorite(Product product) =>
      _favorites.any((p) => p.id == product.id);
}
