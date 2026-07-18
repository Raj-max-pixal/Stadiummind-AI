import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../core/constants/app_constants.dart';
import '../models/user_model.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthService({
    firebase_auth.FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? firebase_auth.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<UserModel?> get userStream {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      return _userFromFirebase(user);
    });
  }

  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return _userFromFirebase(user);
  }

  Future<UserModel?> registerWithEmailPassword({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) return null;

      await user.updateDisplayName(name);
      await _firestore.collection('users').doc(user.uid).set({
        'email': email,
        'name': name,
        'role': role,
        'isActive': true,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

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
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) return null;

      final profile = await _userFromFirebase(
        user,
        fallbackRole: fallbackRole,
      );

      await _firestore.collection('users').doc(user.uid).set({
        'email': user.email ?? email,
        'name': profile.name,
        'role': profile.role,
        'isActive': true,
        'lastLogin': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return profile;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Login failed');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
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
    final doc = await _firestore.collection('users').doc(user.uid).get();
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
}

final authService = AuthService();
