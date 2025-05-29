import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartViewModel extends ChangeNotifier {
  final Map<Product, int> _cartItems = {};

  Map<Product, int> get cartItems => _cartItems;

  void addProduct(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
    } else {
      _cartItems[product] = 1;
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    if (_cartItems.containsKey(product)) {
      if (_cartItems[product]! > 1) {
        _cartItems[product] = _cartItems[product]! - 1;
      } else {
        _cartItems.remove(product);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int getTotalItems() => _cartItems.values.fold(0, (a, b) => a + b);

  double getTotalPrice() => _cartItems.entries
      .map((e) => e.key.price * e.value)
      .fold(0, (a, b) => a + b);
}
