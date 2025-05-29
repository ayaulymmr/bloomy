import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/order_view_model.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderViewModel>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    final orderVM = Provider.of<OrderViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Мои заказы')),
      body: orderVM.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orderVM.orders.length,
              itemBuilder: (context, index) {
                final order = orderVM.orders[index];
                return ListTile(
                  title: Text('Заказ №${order['id']}'),
                  subtitle: Text('Статус: ${order['status']}'),
                  trailing: Text(order['date'] ?? ''),
                );
              },
            ),
    );
  }
}
