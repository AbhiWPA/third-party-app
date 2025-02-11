// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:http/http.dart' as http; // For making the POST request
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert'; // For encoding the request body
// import '../main.dart';
// import '../presentation/payment_screen.dart';
// import '../screens/login_screen.dart';
// import '../screens/payment_screen.dart';
//
// // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// // FlutterLocalNotificationsPlugin();
//
// class NotificationHandler {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   void initialize(BuildContext context) {
//     _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     // Handle notification when the app is opened from the **terminated state**
//     FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
//       if (message != null) {
//         _showNotificationDialog(
//           title: message.data['title'] ?? "Notification",
//           body: message.data['body'] ?? "You opened a notification.",
//           nic: message.data['nic'] ?? "",
//           amount: message.data['amount'] ?? "",
//           tranRef: message.data['tranRef'] ?? "",
//         );
//       }
//     });
//
//     // Handle **foreground messages**
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("🔥 Foreground message received: ${message.data}");
//
//       String title = message.data['title'] ?? "Notification";
//       String body = message.data['body'] ?? "You have a new message.";
//       String nic = message.data['nic'] ?? "";
//       String amount = message.data['amount'] ?? "";
//       String tranRef = message.data['tranRef'] ?? "";
//
//       print("Title: $title");
//       print("Body: $body");
//       print("NIC: $nic");
//       print("Amount: $amount");
//       print("Transaction Reference: $tranRef");
//
//       _showNotificationDialog(
//         title: title,
//         body: body,
//         nic: nic,
//         amount: amount,
//         tranRef: tranRef,
//       );
//     });
//
//     // Handle **background notifications** when app is opened via tapping a notification
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("📩 Notification Clicked: ${message.data}");
//       _showNotificationDialog(
//         title: message.data['title'] ?? "Notification",
//         body: message.data['body'] ?? "You clicked on a notification.",
//         nic: message.data['nic'] ?? "",
//         amount: message.data['amount'] ?? "",
//         tranRef: message.data['tranRef'] ?? "",
//       );
//     });
//   }
//
//   void _showNotificationDialog({
//     required String title,
//     required String body,
//     required String nic,
//     required String amount,
//     required String tranRef,
//   }) {
//     if (navigatorKey.currentContext == null) {
//       print("⚠️ Navigator context is null, cannot show dialog.");
//       return;
//     }
//
//     showDialog(
//       context: navigatorKey.currentContext!,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(body),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               _navigateToPaymentScreen(nic, amount, tranRef);
//             },
//             child: Text("OK"),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text("Cancel"),
//           ),
//         ],
//       ),
//     ).then((_) {
//       print("✅ Dialog shown successfully.");
//     }).catchError((error) {
//       print("❌ Error showing dialog: $error");
//     });
//   }
//
//   void _navigateToPaymentScreen(String nic, String amount, String tranRef) {
//     Navigator.of(navigatorKey.currentContext!).push(
//       MaterialPageRoute(
//         builder: (context) => PaymentScreen(
//           nic: nic,
//           amount: amount,
//           tranRef: tranRef,
//         ),
//       ),
//     );
//   }
//
//   Future<void> _sendPurchaseRequest(String nic, String amount, String tranRef) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('access_token');
//     final String apiUrl = 'https://epictechdev.com:50422/api/third-party/user/pay-lottery'; // Replace with your API
//
//     final Map<String, dynamic> requestBody = {
//       'nic': nic,
//       'amount': amount,
//       'transactionRef': tranRef,
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: json.encode(requestBody),
//       );
//       // print("Pay Lottery Response : ${response.body}");
//       print("Pay Lottery Request Body : ${requestBody}");
//       if (response.statusCode == 200) {
//         print("Pay Lottery Response : ${response.body}");
//         print("✅ Purchase request successful!");
//       } else {
//         print("❌ Failed to make purchase request. Response: ${response.body}");
//       }
//     } catch (e) {
//       print("❌ Error making purchase request: $e");
//     }
//   }
//
//
// }
//
// // Method to make the POST request
// // Future<void> _makePostRequest() async {
// //   final String apiUrl = 'https://your-api-endpoint.com/endpoint'; // Replace with your API URL
// //
// //   // Define the request body (example body)
// //   final Map<String, dynamic> requestBody = {
// //     'key1': 'value1', // Example data
// //     'key2': 'value2',
// //   };
// //
// //   try {
// //     final response = await http.post(
// //       Uri.parse(apiUrl),
// //       headers: {'Content-Type': 'application/json'},
// //       body: json.encode(requestBody),
// //     );
// //
// //     if (response.statusCode == 200) {
// //       print('POST request successful');
// //     } else {
// //       print('Failed to make POST request');
// //     }
// //   } catch (e) {
// //     print('Error making POST request: $e');
// //   }
// // }
//
// // void _showNotificationDialog(BuildContext context, {required String title, required String body}) {
// //   print("_showNotificationDialog ========= " + context.toString());
// //   print("_showNotificationDialog ========= " + title);
// //   print("_showNotificationDialog ========= " + body);
// //
// //
// //   WidgetsBinding.instance.addPostFrameCallback((_) {
// //     if (!context.mounted) {
// //       print("Context is not mounted!");
// //       return; // Ensure the context is valid
// //     }
// //
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text(title),
// //
// //       ),
// //     ).then((_) {
// //       print("Dialog shown successfully");
// //     }).catchError((error) {
// //       print("Error showing dialog: $error");
// //     });
// //   });
// //
// //
// //
// //   // showDialog(
// //   //   context: context,
// //   //   builder: (context) => AlertDialog(
// //   //     title: Text(title),
// //   //
// //   //   ),
// //   // ).then((_) {
// //   //   print("Dialog shown successfully");
// //   // }).catchError((error) {
// //   //   print("Error showing dialog: $error");
// //   // });
// // }