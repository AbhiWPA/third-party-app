import 'dart:convert';

import 'package:dlbsweep/models/notification_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../presentation/payment_screen.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  NotificationModel? _latestNotification;

  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  NotificationModel? storedNotification;

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
            _navigateToPaymentScreen(data[0], data[1], data[2]);
          }
        }
      },
    );

    print("✅ Notification service initialized");
  }

  // Set up real-time notification listeners
  void setupNotificationListeners() {
    // Listen for notification clicks when the app is in the background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data.isNotEmpty) {
        final nic = message.data['nic'];
        final amount = message.data['amount'];
        final tranRef = message.data['tranRef'];
        if (nic != null && amount != null && tranRef != null) {
          _navigateToPaymentScreen(nic, amount, tranRef);
        }
      }
    });

    // Listen for notifications when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data.isNotEmpty) {
        final nic = message.data['nic'];
        final amount = message.data['amount'];
        final tranRef = message.data['tranRef'];
        if (nic != null && amount != null && tranRef != null) {
          NotificationModel notification =
              NotificationModel.fromMap(message.data);
          showNotification(notification);
        }
      }
    });

    // Handle notification click when the app is closed (terminated)
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null && message.data.isNotEmpty) {
        print("Initial Message ================== ${message.data}");
        final nic = message.data['nic'];
        final amount = message.data['amount'];
        final tranRef = message.data['tranRef'];
        if (nic != null && amount != null && tranRef != null) {
          // Store the notification data for later use
          NotificationModel notification = NotificationModel(
            title: message.data['title'],
            body: message.data['body'],
            nic: nic,
            amount: amount,
            tranRef: tranRef,
          );

          // Navigate to the payment screen when the app is launched
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _navigateToPaymentScreen(nic, amount, tranRef);
          });
        }
      }
    });
  }

  // Show a Local Notification
  Future<void> showNotification(NotificationModel message) async {
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

    String payload = '${message.nic}|${message.amount}|${message.tranRef}';

    await flutterLocalNotificationsPlugin.show(
      0,
      message.title ?? 'New Payment',
      message.body ?? 'You have received a new payment.',
      notificationDetails,
      payload: payload,
    );

    _latestNotification = NotificationModel(
        title: message.title,
        body: message.body,
        nic: message.nic,
        amount: message.amount,
        tranRef: message.tranRef);

    print("📩 Notification shown: ${message.title}, ${message.body}");
  }

  static void _navigateToPaymentScreen(
      String nic, String amount, String tranRef) {
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
