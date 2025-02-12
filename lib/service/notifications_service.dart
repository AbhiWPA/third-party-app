import 'package:dlbsweep/models/notification_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../presentation/payment_screen.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  // Initialize Notification Plugin
  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        print("🔔 Notification Clicked! Payload: ${details.payload}");
        if (details.payload != null) {
          List<String> data = details.payload!.split('|');
          if (data.length == 3) {
            if (details.payload != null) {
              List<String> data = details.payload!.split('|');
              if (data.length == 3) {
                _navigateToPaymentScreen(data[0], data[1], data[2]);
              }
            }
          }
        }
      },
    );
    print("✅ Notification service initialized");
  }

  // Show a Local Notification
  Future<void> showNotification(NotificationModel notification) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    String payload = '${notification.nic}|${notification.amount}|${notification.tranRef}';

    await flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      notificationDetails,
      payload: payload,
    );
    print("📩 Notification shown: ${notification.title}, ${notification.body}");
  }

  static void _navigateToPaymentScreen(String nic, String amount, String tranRef) {
    // Ensure navigatorKey is available
    if (navigatorKey.currentContext != null) {
      Navigator.of(navigatorKey.currentContext!).push(
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            nic: nic,
            amount: amount,
            tranRef: tranRef,
          ),
        ),
      );
    }
  }
}