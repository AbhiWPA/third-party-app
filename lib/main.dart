import 'package:dlbsweep/presentation/login_screen.dart';
import 'package:dlbsweep/presentation/merchant_screen.dart';
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

  runApp(DLBApp());
}

Future<void> checkTokenAndNavigate(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');

  if (token != null) {
    // Navigate to MerchantScreen if token is available
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => MerchantScreen()),
    );
  }
}

class DLBApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final prefs = snapshot.data as SharedPreferences;
            final token = prefs.getString('access_token');

            // Navigate to MerchantScreen if token is available
            if (token != null) {
              return MerchantScreen();
            } else {
              return WelcomeScreen();
            }
          } else {
            // Show a loading indicator while checking for the token
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}