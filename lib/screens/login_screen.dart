// import 'dart:convert';
// import 'package:dlbsweep/presentation/welcome_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:dlbsweep/screens/registration_screen.dart';
// import 'package:dlbsweep/screens/welcome_screen.dart';
// import 'package:dlbsweep/util/token_util.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../beans/login_bean.dart';
// import 'grid_view_page.dart';
// import 'nic_button_screen.dart';
//
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _nicController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   void _navigateToRegister() {
//     // Uncomment and implement registration navigation logic if needed
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => RegistrationScreen(),
//       ),
//     );
//   }
//
//   void _login() async {
//      final nic = _nicController.text;
//     final password = _passwordController.text;
//
//     LoginReqBean loginReqBean = LoginReqBean(
//       nic: _nicController.text,
//       password: _passwordController.text,
//     );
//
//     try {
//       final response = await http.post(
//         Uri.parse('https://epictechdev.com:50422/api/third-party/user/login'),
//         headers: {'Content-Type': 'application/json'},
//         // Specify JSON content type
//         body: jsonEncode(
//             loginReqBean.toJson()), // Pass NIC number from the passed data
//       );
//
//       print('Response Status Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = jsonDecode(response.body);
//
//         if (responseData['status'] == 'R000' &&
//             responseData['content'] != null) {
//           print('Login successful!');
//
//           final String accessToken = responseData['content']['access_token'];
//           final prefs = await SharedPreferences.getInstance();
//           await prefs.setString('access_token', accessToken);
//
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   GridViewPage(
//                       nic: '$nic'), // Replace with your NIC button screen widget
//             ),
//           );
//         } else {
//           print(
//               'Invalid response structure or status: ${responseData['message']}');
//         }
//       } else {
//         print('Failed to check user: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching NICs: $e');
//     }
//
//     // Add your login logic here
//     print('NIC: $nic');
//     print('Password: $password');
//   }
//
//   void _navigateToWelcome(BuildContext context) {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => WelcomeScreen()),
//           (route) => false, // Remove all previous routes
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Demo App Login', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => _navigateToWelcome(context), // Pass as a callback
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//             Center(
//             child: Text(
//             'Login',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             ),
//                 SizedBox(height: 16),
//             // const SizedBox(height: 20),
//             // NIC TextField
//             TextField(
//               controller: _nicController,
//               decoration: InputDecoration(
//                 labelText: 'Enter NIC',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Password TextField
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(
//                 labelText: 'Enter Password',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               obscureText: true,
//             ),
//             const SizedBox(height: 24),
//             // Login Button
//             ElevatedButton(
//               onPressed: _login,
//               child: const Text('Login'),
//             ),
//             const SizedBox(height: 24),
//             // Register navigation
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Don't have an account? "),
//                   GestureDetector(
//                     onTap: _navigateToRegister,
//                     child: const Text(
//                       'Register',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ],
//           ),
//         ),
//       ),
//     ),);
//   }
// }
