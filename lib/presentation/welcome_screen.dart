import 'package:dlbsweep/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../business/welcome_viewmodel.dart';

class WelcomeScreen extends StatelessWidget {

  const WelcomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WelcomeViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Start Demo App', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.blue, // Optional, use your desired color
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/welcome.jpg', // Replace with your image path
                  fit: BoxFit.cover,
                ),
                const Spacer(), // Push content to center vertically
                const Text(
                  'Welcome to Our App',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Ensure text is visible over the image
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Discover amazing features and get started on your journey!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54, // Adjust color for visibility
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => _navigateToLogin(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const Spacer(), // Push content to center vertically
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
    );
  }
}
