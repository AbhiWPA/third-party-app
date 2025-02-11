import 'package:dlbsweep/presentation/welcome_screen.dart';
import 'package:dlbsweep/service/firebase_service.dart';
import 'package:dlbsweep/service/notifications_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize Services
  FirebaseService firebaseService = FirebaseService();
  NotificationService notificationService = NotificationService();

  firebaseService.initializeFirebase();
  firebaseService.getFCMToken();

  // Set up background message handler
  await firebaseService.setupBackgroundMessageHandler();

  // Initialize Notifications
  await notificationService.initialize();

  runApp(DLBApp());
}

class DLBApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // LocalNotifications.init(context);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

// // ✅ Background Message Handler (for when the app is killed)
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   // _handleNotification(message);
//   if (message != null) {
//     _showNotificationDialog(
//       title: message.data['title'] ?? "Notification",
//       body: message.data['body'] ?? "You opened a notification.",
//       nic: message.data['nic'] ?? "",
//       amount: message.data['amount'] ?? "",
//       tranRef: message.data['tranRef'] ?? "",
//     );
//   }
//   print('🔥 Background message received: ${message.messageId}');
// }
//
// void _showNotificationDialog({required title, required body, required nic, required amount, required tranRef}) {
//   LocalNotifications.showNotification(title: title, body: body, nic: nic, amount: amount, tranRef: tranRef);
// }
//
// Future<void> requestPermissions() async {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//       ?.requestPermission();
// }
//
// extension on AndroidFlutterLocalNotificationsPlugin? {
//   void requestPermission() {}
// }

