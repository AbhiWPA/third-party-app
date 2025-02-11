// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
//
// import '../presentation/login_screen.dart';
// import 'login_screen.dart';
//
// class GridViewPage extends StatelessWidget {
//   // final String name;
//   final String nic;
//
//   GridViewPage({Key? key, required this.nic}) : super(key: key);
//
//
//   void _navigateToLogin(BuildContext context) {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//           (route) => false, // Remove all previous routes
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Registered Merchants', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => _navigateToLogin(context), // Pass as a callback
//         ),
//       ),
//       body: GridView(
//         padding: const EdgeInsets.all(16.0),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 12.0,
//           mainAxisSpacing: 12.0,
//           childAspectRatio: 1,
//         ),
//         children: [
//           _buildMerchantButton(
//             context: context,
//             id: 1,
//             imagePath: 'assets/keells.jpeg',
//             url: 'https://example.com/merchant1',
//           ),
//           _buildMerchantButton(
//             context: context,
//             id: 2,
//             imagePath: 'assets/foodCity.jpeg',
//             url: 'https://example.com/merchant2',
//           ),
//           _buildMerchantButton(
//             context: context,
//             id: 3,
//             imagePath: 'assets/Damro.jpeg',
//             url: 'https://example.com/merchant3',
//           ),
//           _buildMerchantButton(
//             context: context,
//             id: 4,
//             imagePath: 'assets/abans.jpeg',
//             url: 'https://buyabans.com/',
//           ),
//           _buildMerchantButton(
//             context: context,
//             id: 5,
//             imagePath: 'assets/dlbSweep.jpeg',
//             url: 'https://epictechdev.com:50345',
//           ),
//           _buildMerchantButton(
//             context: context,
//             id: 6,
//             imagePath: 'assets/iit.jpeg',
//             url: 'https://example.com/merchant6',
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMerchantButton({
//     required BuildContext context,
//     required String imagePath,
//     required String url,
//     required int id,
//   }) {
//     return GestureDetector(
//       onTap: () async {
//         final prefs = await SharedPreferences.getInstance();
//         final token = prefs.getString('access_token');
//         final pushId = prefs.getString('fcm_token');
//         print("Merchant Screen : " + pushId!);
//
//         if (token == null || token.isEmpty) {
//           _showUnauthorizedDialog(context);
//           return; // Exit if no token is found
//         }
//
//         if (id == 5) {
//           await _handleSpecialMerchant(token, pushId);
//         } else {
//           final uri = Uri.parse(url);
//           if (await canLaunchUrl(uri)) {
//             await launchUrl(uri, mode: LaunchMode.externalApplication);
//           } else {
//             print('Could not launch $url');
//           }
//         }
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8.0),
//           image: DecorationImage(
//             image: AssetImage(imagePath),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _handleSpecialMerchant(String token, String pushId) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://epictechdev.com:50422/api/third-party/user/check-user'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode({'nicNumber': nic, 'pushId': pushId}),
//       );
//
//       print("Response: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = jsonDecode(response.body);
//
//         if ((responseData['status'] == '0011' || responseData['status'] == '0010') && responseData['content'] != null) {
//           final String redirectUrl = responseData['content']['url'];
//
//           final uri = Uri.parse(redirectUrl);
//           if (await canLaunchUrl(uri)) {
//             await launchUrl(uri, mode: LaunchMode.externalApplication);
//           } else {
//             print('Could not launch $redirectUrl');
//           }
//         } else {
//           print('Invalid response or status: ${responseData['message']}');
//         }
//       } else {
//         print('Failed to check user: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   void _showUnauthorizedDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Unauthorized Access'),
//           content: const Text('Please log in to access this feature.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
