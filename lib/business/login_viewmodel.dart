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
    bool? loginResponse;
    if ((loginModel.nic.isNotEmpty && loginModel.password.isNotEmpty)) {
      loginResponse = await _authService.login(loginModel);
    }

    _isLoading = false;
    notifyListeners();

    // Navigate to GridViewPage on successful login

    if (loginResponse == true) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MerchantScreen()),
      );
    } else {
      // Show an error message if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please check your credentials.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
