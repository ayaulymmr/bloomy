import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  String _email = '';
  bool _isLoggedIn = false;

  String get email => _email;
  bool get isLoggedIn => _isLoggedIn;

  LoginViewModel() {
    _loadSavedUser();
  }

  Future<void> _loadSavedUser() async {
    final savedEmail = await AuthService.getEmail();
    if (savedEmail != null && savedEmail.isNotEmpty) {
      _email = savedEmail;
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    // Здесь должна быть настоящая логика аутентификации
    _email = email;
    _isLoggedIn = true;
    await AuthService.saveEmail(email);
    notifyListeners();
  }

  Future<void> logout() async {
    _email = '';
    _isLoggedIn = false;
    await AuthService.clear();
    notifyListeners();
  }
}
