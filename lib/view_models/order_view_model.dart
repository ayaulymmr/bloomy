import 'package:flutter/foundation.dart';
import '../services/api_service.dart';

class OrderViewModel extends ChangeNotifier {
  List<dynamic> _orders = [];
  bool _isLoading = false;

  List<dynamic> get orders => _orders;
  bool get isLoading => _isLoading;

  Future<void> fetchOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      _orders = await ApiService.fetchOrders();
    } catch (e) {
      _orders = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
