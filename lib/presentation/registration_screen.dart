import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../business/registration_viewmodel.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegistrationViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: Consumer<RegistrationViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildInputBox("NIC", _nicController),
                  _buildInputBox("First Name", _firstNameController),
                  _buildInputBox("Last Name", _lastNameController),
                  _buildInputBox("Email", _emailController, TextInputType.emailAddress),
                  _buildInputBox("Mobile Number", _mobileNumberController, TextInputType.phone),
                  _buildInputBox("Password", _passwordController, TextInputType.text, true),

                  SizedBox(height: 24),
                  viewModel.isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () {
                      viewModel.register(
                        _nicController.text,
                        _firstNameController.text,
                        _lastNameController.text,
                        _emailController.text,
                        _mobileNumberController.text,
                        _passwordController.text,
                        context,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                    ),
                    child: Text(
                        'Register',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInputBox(String label, TextEditingController controller,
      [TextInputType inputType = TextInputType.text, bool obscureText = false]) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: TextField(
          controller: controller,
          keyboardType: inputType,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
