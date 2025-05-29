import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/cart_view_model.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartVM = context.watch<CartViewModel>();
    final items = cartVM.cartItems;

    return Scaffold(
      appBar: AppBar(title: Text('Корзина')),
      body: items.isEmpty
          ? Center(child: Text('Корзина пуста'))
          : ListView(
              children: items.entries.map((entry) {
                final product = entry.key;
                final quantity = entry.value;
                return ListTile(
                  leading: Image.network(product.imageUrl, width: 50),
                  title: Text(product.name),
                  subtitle: Text('₽${product.price} x $quantity'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      cartVM.removeProduct(product);
                    },
                  ),
                );
              }).toList(),
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Оформление заказа не реализовано')),
            );
          },
          child: Text('Перейти к оплате (${cartVM.getTotalPrice().toStringAsFixed(2)} ₽)'),
        ),
      ),
    );
  }
}
