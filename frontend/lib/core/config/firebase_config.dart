import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static const Duration _initializeTimeout = Duration(seconds: 8);
  static bool _isAvailable = false;

  static bool get isAvailable => _isAvailable;

  static Future<void> initialize() async {
    try {
      if (Firebase.apps.isNotEmpty) {
        _isAvailable = true;
        return;
      }

      final options = _optionsFromEnvironment();
      if (options != null) {
        await Firebase.initializeApp(options: options)
            .timeout(_initializeTimeout);
      } else {
        await Firebase.initializeApp().timeout(_initializeTimeout);
      }

      _isAvailable = true;
      if (kDebugMode) {
        print('Firebase initialized');
      }
    } catch (e) {
      _isAvailable = false;
      if (kDebugMode) {
        print('Firebase initialization error: $e');
      }
    }
  }

  static FirebaseOptions? _optionsFromEnvironment() {
    const apiKey = String.fromEnvironment('FIREBASE_API_KEY');
    const appId = String.fromEnvironment('FIREBASE_APP_ID');
    const messagingSenderId =
        String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
    const projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
    const authDomain = String.fromEnvironment('FIREBASE_AUTH_DOMAIN');
    const storageBucket = String.fromEnvironment('FIREBASE_STORAGE_BUCKET');
    const measurementId = String.fromEnvironment('FIREBASE_MEASUREMENT_ID');

    if (apiKey.isEmpty ||
        appId.isEmpty ||
        messagingSenderId.isEmpty ||
        projectId.isEmpty) {
      return null;
    }

    return const FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      authDomain: authDomain,
      storageBucket: storageBucket,
      measurementId: measurementId,
    );
  }
}
