// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
//
// import '../main.dart';
// import '../presentation/payment_screen.dart';
// import '../screens/payment_screen.dart';
//
// class LocalNotifications {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   static Future<void> init(BuildContext context) async {
//     // Initialize Android settings
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     // Initialize iOS settings
//     final DarwinInitializationSettings initializationSettingsDarwin =
//     DarwinInitializationSettings();
//
//     // Initialize Linux settings
//     final LinuxInitializationSettings initializationSettingsLinux =
//     LinuxInitializationSettings(defaultActionName: 'Open notification');
//
//     // Combine all initialization settings
//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//       macOS: initializationSettingsDarwin,
//       linux: initializationSettingsLinux,
//     );
//
//     // Initialize the plugin and set the callback for when a notification is clicked
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse details) {
//         print("🔔 Notification Clicked! Payload: ${details.payload}");
//
//         // Extract payload data
//         if (details.payload != null) {
//           List<String> data = details.payload!.split('|');
//           if (data.length == 3) {
//             _navigateToPaymentScreen(data[0], data[1], data[2]);
//           }
//         }
//       },
//     );
//   }
//
//   static void _navigateToPaymentScreen(String nic, String amount, String tranRef) {
//     // Ensure navigatorKey is available
//     if (navigatorKey.currentContext != null) {
//       Navigator.of(navigatorKey.currentContext!).push(
//         MaterialPageRoute(
//           builder: (context) => PaymentScreen(
//             nic: nic,
//             amount: amount,
//             tranRef: tranRef,
//           ),
//         ),
//       );
//     }
//   }
//
//   static Future<void> showNotification({
//     required String title,
//     required String body,
//     required String nic,
//     required String amount,
//     required String tranRef,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//     AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       channelDescription: 'your channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//
//     const NotificationDetails notificationDetails =
//     NotificationDetails(android: androidNotificationDetails);
//
//     // Pass transaction details as payload
//     String payload = '$nic|$amount|$tranRef';
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       notificationDetails,
//       payload: payload, // Pass transaction data
//     );
//   }
// }
