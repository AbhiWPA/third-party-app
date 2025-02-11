// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'login_screen.dart';
// import 'grid_view_page.dart';
//
// class NICButtonScreen extends StatefulWidget {
//   @override
//   _NICButtonScreenState createState() => _NICButtonScreenState();
// }
//
// class _NICButtonScreenState extends State<NICButtonScreen> {
//   List<dynamic> nicList = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkTokenAndFetchNICs(); // Check token before fetching NICs
//   }
//
//   Future<void> _checkTokenAndFetchNICs() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('access_token');
//
//     if (token == null || token.isEmpty) {
//       _showUnauthorizedAccessDialog();
//     } else {
//       fetchNICs(token);
//     }
//   }
//
//   void _showUnauthorizedAccessDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false, // Prevent dismissal by tapping outside
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Unauthorized Access'),
//           content: const Text('You are not authorized to access this screen.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                 );
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> fetchNICs(String token) async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://192.168.20.239:7272/api/third-party/user'),
//         headers: {
//           'Authorization': 'Bearer $token', // Use the token in the request header
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['status'] == 'R000') {
//           setState(() {
//             nicList = data['content'];
//             isLoading = false;
//           });
//         } else {
//           throw Exception('API returned an error: ${data['message']}');
//         }
//       } else {
//         throw Exception('Failed to load NICs');
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print('Error fetching NICs: $e');
//     }
//   }
//
//   void _navigateToLogin() {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//           (route) => false, // This removes all previous routes
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Registered Users'),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: _navigateToLogin, // Navigate back to login screen
//         ),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : nicList.isEmpty
//           ? const Center(child: Text('No NICs found'))
//           : ListView.builder(
//         itemCount: nicList.length,
//         itemBuilder: (context, index) {
//           final user = nicList[index];
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blueAccent,
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 minimumSize: const Size(200, 50),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => GridViewPage(
//                       name: user['name'],
//                       nic: user['nic'],
//                     ),
//                   ),
//                 );
//               },
//               child: Text('${user['name']}: ${user['nic']}'),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
