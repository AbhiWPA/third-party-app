// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
//
// import '../push/notification_handler.dart';
// import 'login_screen.dart';
//
// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }
//
// class _WelcomeScreenState extends State<WelcomeScreen> {
//   final NotificationHandler _notificationHandler = NotificationHandler();
//   late FirebaseMessaging _messaging;
//   bool _isFirebaseInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeFirebase();
//     _notificationHandler.initialize(context);
//   }
//
//   Future<void> _initializeFirebase() async {
//     // await Firebase.initializeApp();
//     setState(() {
//       _isFirebaseInitialized = true;
//     });
//     _messaging = FirebaseMessaging.instance;
//     _initializeFirebaseAndSaveToken();
//     _requestPermissions();
//     _getTokenAndSaveLocally();
//     // _setupFCMListeners();
//   }
//
//   Future<void> _initializeFirebaseAndSaveToken() async {
//     // Initialize Firebase
//     await Firebase.initializeApp();
//
//     // Get Firebase Messaging instance
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//     // Get the FCM token
//     String? token = await messaging.getToken();
//
//     if (token != null) {
//       print("FCM Token: $token");
//
//       // Save the token to SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       // await prefs.setString('pushId', token);
//       print("Token saved to local storage");
//     } else {
//       print("Failed to get FCM token");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Start Demo App', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: Colors.blue, // Optional, use your desired color
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Spacer(), // Push content to center vertically
//           const Text(
//             'Welcome to Our App',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'Discover amazing features and get started on your journey!',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton(
//             onPressed: () => _navigateToLogin(context),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue, // Button color
//               padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//             child: const Text(
//               'Get Started',
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//           const Spacer(), // Push content to center vertically
//         ],
//       ),
//     );
//   }
//
//   void _navigateToLogin(BuildContext context) {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//           (route) => false, // Remove all previous routes
//     );
//   }
//
//   void _requestPermissions() async {
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     print('User granted permission: ${settings.authorizationStatus}');
//   }
//
//   void _getTokenAndSaveLocally() async {
//     String? token = await _messaging.getToken();
//     if (token != null) {
//       print('FCM Token: $token');
//
//       // Save the token to local storage
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('fcm_token', token);
//
//       // Optionally, share the token with your backend
//       print('FCM token saved locally');
//     }
//   }
//
//   // void _setupFCMListeners() {
//   //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//   //     print(
//   //         'Message received: ${message.notification?.title}, ${message.notification?.body}');
//   //     // Show a dialog or update the UI based on the notification
//   //   });
//   //
//   //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//   //     print('Notification clicked!');
//   //     // Handle navigation or other actions when the app is opened via a notification
//   //   });
//   // }
// }