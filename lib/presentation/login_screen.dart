import 'package:carousel_slider/carousel_slider.dart';
import 'package:dlbsweep/presentation/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../business/login_viewmodel.dart';
import 'welcome_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationScreen(),
      ),
    );
  }

  void _navigateToWelcome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LOGIN', style: TextStyle(color: Colors.black54)),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _navigateToWelcome(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Shape
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    decoration: BoxDecoration(
                      // color: Colors.blue, // Background color for the header shape
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    child: Center(
                      child: Text(
                        'Welcome back!',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // NIC TextField
                  TextField(
                    controller: _nicController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Password TextField
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  // Remember me and Forget password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (value) {}),
                          Text('Remember me'),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Forget password?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Login Button
                  Consumer<LoginViewModel>(
                    builder: (context, viewModel, child) {
                      return ElevatedButton(
                        onPressed: viewModel.isLoading
                            ? null
                            : () => viewModel.login(
                          _nicController.text,
                          _passwordController.text,
                          context,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: viewModel.isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : const Text('Login', style: TextStyle(fontSize: 18)),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  // OR Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('OR'),
                      ),
                      Expanded(
                        child: Divider(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Sign in with another account
                  Center(
                    child: Text(
                      'Sign in with another account',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Social Media Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.facebook, color: Colors.black54),
                        onPressed: () {
                          // Add Facebook link here
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.link, color: Colors.black54),
                        onPressed: () {
                          // Add LinkedIn link here
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.email, color: Colors.black54),
                        onPressed: () {
                          // Add email link here
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Register navigation
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("New user? "),
                        GestureDetector(
                          onTap: () => _navigateToRegister(context),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliderWithHeader() {
    final List<Map<String, String>> sliderItems = [
      {
        'title': '',
        'imageUrl': 'https://www.genie.lk/wp-content/uploads/2024/10/Dialog-in-app-biller-discount-for-any-Mastercardv2-1890x1100-1.jpg'
      },
      {
        'title': '',
        'imageUrl': 'https://www.genie.lk/wp-content/uploads/2025/01/Exclusive-25-Discount-1890x1100-1.jpg'
      },
      {
        'title': '',
        'imageUrl': 'https://www.genie.lk/wp-content/uploads/2023/11/genie-X-MasterCard-iPhone-15-Bonanza-1890x1100-2.jpg'
      },
    ];

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180.0,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: sliderItems.map((item) {
            return Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(item['imageUrl']!, fit: BoxFit.cover, width: double.infinity),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black54, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  ),
                  child: Text(
                    item['title']!,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}