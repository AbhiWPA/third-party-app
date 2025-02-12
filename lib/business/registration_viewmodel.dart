import 'package:dlbsweep/presentation/login_screen.dart';
import 'package:flutter/material.dart';

import '../beans/register_bean.dart';
import '../service/registration_service.dart';

class RegistrationViewModel extends ChangeNotifier {
  final RegistrationService _registrationService = RegistrationService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> register(
      String nic,
      String firstname,
      String lastname,
      String email,
      String mobileNumber,
      String password,
      BuildContext context,
      ) async {
    setLoading(true);
    RegisterReqBean user = RegisterReqBean(nic, firstname, lastname, email, mobileNumber, password);

    try {
      final response = await _registrationService.registerUser(user);
      setLoading(false);

      if (response['status'] == 'R000') {
        _showDialog(context, "Registration Successful", "Please log in with your account.");
      } else {
        _showDialog(context, "Registration Failed", response['message'] ?? "Please try again.");
      }
    } catch (e) {
      setLoading(false);
      _showDialog(context, "Error", "Something went wrong: $e");
    }
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => navigateToLogin(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void navigateToLogin(BuildContext context) {
    if (context != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }
}
