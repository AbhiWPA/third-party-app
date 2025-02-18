import 'dart:convert';

import 'package:dlbsweep/models/notification_model.dart';
import 'package:dlbsweep/presentation/login_screen.dart';
import 'package:dlbsweep/presentation/merchant_screen.dart';
import 'package:dlbsweep/presentation/payment_screen.dart';
import 'package:dlbsweep/presentation/welcome_screen.dart';
import 'package:dlbsweep/service/firebase_service.dart';
import 'package:dlbsweep/service/notifications_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // Set up notification listeners
  notificationService.setupNotificationListeners();

  runApp(DLBApp());
}

class DLBApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Future.wait([
          SharedPreferences.getInstance(),
          FirebaseMessaging.instance.getInitialMessage(), // Handle initial notification
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final prefs = snapshot.data![0] as SharedPreferences;
            // final RemoteMessage? initialMessage = snapshot.data![1] as RemoteMessage?;
            // final prefs = await SharedPreferences.getInstance();
            final token = prefs.getString('access_token');
            final notification = prefs.getString('notification');

            print("notification =================== $notification");
            print("App killed Initial process =========== $token");

            // 🚀 Navigate Based on Token
            if (token != null && token.isNotEmpty) {
              if (notification != null) {
                final Map<String, dynamic> notificationMap =
                jsonDecode(notification);
                print("=========== notificationMap | ${notificationMap} ======================");
                var notificationModel = NotificationModel.fromMap(notificationMap);
                print("=========== notificationModel | ${notificationModel} ======================");

                if (notificationModel != null) {
                  return PaymentScreen(
                    nic: notificationModel.nic,
                    amount: notificationModel.amount,
                    tranRef: notificationModel.tranRef,
                  );
                }
              }
              return MerchantScreen();
            } else {
              return WelcomeScreen();
            }
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
