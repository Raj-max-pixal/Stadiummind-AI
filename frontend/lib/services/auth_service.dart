import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../core/config/firebase_config.dart';
import '../core/constants/app_constants.dart';
import '../models/user_model.dart';

class AuthService {
  static const Duration _authTimeout = Duration(seconds: 10);
  static const Duration _firestoreTimeout = Duration(seconds: 8);

  final firebase_auth.FirebaseAuth? _injectedAuth;
  final FirebaseFirestore? _injectedFirestore;

  AuthService({
    firebase_auth.FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _injectedAuth = auth,
        _injectedFirestore = firestore;

  firebase_auth.FirebaseAuth get _auth =>
      _injectedAuth ?? firebase_auth.FirebaseAuth.instance;

  FirebaseFirestore get _firestore =>
      _injectedFirestore ?? FirebaseFirestore.instance;

  Stream<UserModel?> get userStream {
    _ensureFirebaseReady();
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      return _userFromFirebase(user);
    });
  }

  Future<UserModel?> getCurrentUser() async {
    _ensureFirebaseReady();
    final user = _auth.currentUser;
    if (user == null) return null;
    return _userFromFirebase(user).timeout(_firestoreTimeout);
  }

  Future<UserModel?> registerWithEmailPassword({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    try {
      _ensureFirebaseReady();
      final credential = await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .timeout(_authTimeout);

      final user = credential.user;
      if (user == null) return null;

      await user.updateDisplayName(name).timeout(_authTimeout);
      await _firestore.collection('users').doc(user.uid).set({
        'email': email,
        'name': name,
        'role': role,
        'isActive': true,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)).timeout(_firestoreTimeout);

      return UserModel(
        id: user.uid,
        email: email,
        name: name,
        role: role,
        isActive: true,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Registration failed');
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<UserModel?> loginWithEmailPassword({
    required String email,
    required String password,
    String fallbackRole = AppConstants.roleFan,
  }) async {
    try {
      _ensureFirebaseReady();
      final credential = await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .timeout(_authTimeout);

      final user = credential.user;
      if (user == null) return null;

      final profile = await _userFromFirebase(
        user,
        fallbackRole: fallbackRole,
      ).timeout(_firestoreTimeout);

      await _firestore.collection('users').doc(user.uid).set({
        'email': user.email ?? email,
        'name': profile.name,
        'role': profile.role,
        'isActive': true,
        'lastLogin': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)).timeout(_firestoreTimeout);

      return profile;
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        try {
          return await registerWithEmailPassword(
            email: email,
            password: password,
            name: email.split('@').first,
            role: fallbackRole,
          );
        } on Exception {
          throw Exception(e.message ?? 'Login failed');
        }
      }
      throw Exception(e.message ?? 'Login failed');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      _ensureFirebaseReady();
      await _auth.signOut().timeout(_authTimeout);
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      _ensureFirebaseReady();
      await _auth.sendPasswordResetEmail(email: email).timeout(_authTimeout);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Password reset failed');
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  Future<UserModel> _userFromFirebase(
    firebase_auth.User user, {
    String fallbackRole = AppConstants.roleFan,
  }) async {
    final doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .get()
        .timeout(_firestoreTimeout);
    final data = doc.data() ?? {};

    return UserModel(
      id: user.uid,
      email: user.email ?? data['email']?.toString() ?? '',
      name: data['name']?.toString() ??
          user.displayName ??
          user.email?.split('@').first ??
          'StadiumMind User',
      role: data['role']?.toString() ?? fallbackRole,
      phoneNumber: data['phoneNumber']?.toString(),
      profileImageUrl: data['profileImageUrl']?.toString(),
      isActive: data['isActive'] as bool? ?? true,
      createdAt: _dateFromTimestamp(data['createdAt']),
      lastLogin: _dateFromTimestamp(data['lastLogin']) ?? DateTime.now(),
    );
  }

  DateTime? _dateFromTimestamp(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }

  void _ensureFirebaseReady() {
    if (!FirebaseConfig.isAvailable) {
      throw Exception(
        'Firebase is not configured for this web build. Rebuild with Firebase dart-define values, then deploy again.',
      );
    }
  }
}

final authService = AuthService();
