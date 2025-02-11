import 'package:flutter/material.dart';

import '../service/firebase_service.dart';

class WelcomeViewModel with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  bool _isFirebaseInitialized = false;

  bool get isFirebaseInitialized => _isFirebaseInitialized;

  Future<void> initializeFirebase() async {
    await _firebaseService.initializeFirebase();
    _isFirebaseInitialized = true;
    notifyListeners();
  }

  Future<void> initializeFirebaseAndSaveToken() async {
    await initializeFirebase();
    String? token = await _firebaseService.getFCMToken();
    if (token != null) {
      await _firebaseService.saveTokenLocally(token);
    }
  }

  Future<void> requestPermissions() async {
    await _firebaseService.requestPermissions();
  }
}