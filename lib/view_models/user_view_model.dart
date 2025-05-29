import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  String? _email;

  String? get email => _email;

  bool get isLoggedIn => _email != null;

  void login(String email, String password) {
    // Mock login logic (no real auth)
    _email = email;
    notifyListeners();
  }

  void logout() {
    _email = null;
    notifyListeners();
  }
}
