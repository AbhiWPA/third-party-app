import 'package:dlbsweep/models/login_model.dart';
import 'package:dlbsweep/presentation/merchant_screen.dart';
import 'package:flutter/material.dart';
import '../service/auth_service.dart';

class LoginViewModel with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Login method
  Future<void> login(String nic, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    LoginModel loginModel = LoginModel(nic: nic, password: password);

    await _authService.login(loginModel);

    _isLoading = false;
    notifyListeners();

    // Navigate to GridViewPage on successful login
    if (!_isLoading) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MerchantScreen(nic: nic),
        ),
      );
    }
  }
}