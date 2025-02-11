import 'dart:convert';

import 'package:dlbsweep/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:dlbsweep/beans/register_bean.dart';
import 'package:http/http.dart' as http;

import '../main.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    String nic = _nicController.text;
    String firstname = _firstNameController.text;
    String lastname = _lastNameController.text;
    String email = _emailController.text;
    String mobileNumber = _mobileNumberController.text;
    String password = _passwordController.text;

    RegisterReqBean registerReqBean = RegisterReqBean(
        nic,
        firstname,
        lastname,
        email,
        mobileNumber,
        password
    );

    try {
      final response = await http.post(
        Uri.parse('https://epictechdev.com:50422/api/third-party/user/register'),
        headers: {'Content-Type': 'application/json'}, // Specify JSON content type
        body: jsonEncode(registerReqBean.toJson()), // Pass NIC number from the passed data
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['status'] == 'R000') {
          print('Registration successful!');

          // final String accessToken = responseData['content']['access_token'];
          // final prefs = await SharedPreferences.getInstance();
          // await prefs.setString('access_token', accessToken);

          showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) => AlertDialog(
              title: Text("Registration Successfully"),
              content: Text("Please Logon with your account!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _navigateToLogin();
                  },
                  child: Text("OK"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancel"),
                ),
              ],
            ),
          );


        } else {
          print(
              'Invalid response structure or status: ${responseData['message']}');
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) => AlertDialog(
              title: Text("Registration Failed"),
              content: Text("Please Try again!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _navigateToLogin();
                  },
                  child: Text("OK"),
                ),
              ],
            ),
          );


        }
      } else {
        print('Failed to check user: ${response.statusCode}');

        showDialog(
          context: navigatorKey.currentContext!,
          builder: (context) => AlertDialog(
            title: Text("Registration Failed"),
            content: Text("Please Try again!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _navigateToLogin();
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error fetching NICs: $e');
    }

    // Add registration logic here
    print('First Name: $firstname');
    print('Last Name: $lastname');
    print('Email: $email');
    print('Mobile Number: $mobileNumber');
    print('Password: $password');
  }

  void _navigateToLogin() {
    Navigator.pop(context); // Navigate back to the previous screen (login screen)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo App Register', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _navigateToLogin, // Navigate back to login screen
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 16),

                TextField(
                  controller: _nicController,
                  decoration: InputDecoration(
                    labelText: 'NIC',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // First Name
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Last Name
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Email
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                // Mobile Number
                TextField(
                  controller: _mobileNumberController,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                // Password
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                // Register Button
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        )

      ),
    );
  }
}
