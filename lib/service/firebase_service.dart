import 'dart:convert';

import 'package:dlbsweep/business/notification_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/notification_model.dart';

class FirebaseService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Initialize Firebase
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    print("✅ Firebase initialized");
  }

  // Get FCM Token
  Future<String?> getFCMToken() async {
    String? token = await _messaging.getToken();
    if (token != null) {
      print("FCM Token: $token");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', token);

      // Optionally, share the token with your backend
      print('FCM token saved locally');
    } else {
      print("Failed to get FCM token");
    }
    return token;
  }

  // Save FCM Token to Local Storage
  Future<void> saveTokenLocally(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', token);
    print("Token saved to local storage");
  }

  // Request Notification Permissions
  Future<NotificationSettings> requestPermissions() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    return settings;
  }

  // Handle Background Messages
  Future<void> setupBackgroundMessageHandler() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    print("✅ Background message handler set up");
  }

  // Background Message Handler
  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    NotificationViewModel notificationViewModel = NotificationViewModel();
    if (message.data.isNotEmpty) {
      NotificationModel notification = NotificationModel.fromMap(message.data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('notification', jsonEncode(notification.toMap()));

      notificationViewModel.showNotification(notification);
      print('🔥 Background message received: ${message.messageId}');
      print('Title: ${message.data['title']}');
      print('Body: ${message.data['body']}');
      print('NIC: ${message.data['nic']}');
      print('Amount: ${message.data['amount']}');
      print('Transaction Ref: ${message.data['tranRef']}');
    }
  }
}