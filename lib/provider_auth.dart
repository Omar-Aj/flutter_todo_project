import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDetails {
  final String email;
  final String password;
  final String name;
  final String mobileNumber;

  UserDetails({
    required this.email,
    required this.password,
    required this.name,
    required this.mobileNumber,
  });
}

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User? _loggedInUser;

  User? get loggedInUser => _loggedInUser;

  bool get isLoggedIn => _auth.currentUser != null;

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String mobileNumber,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update loggedInUser
      _loggedInUser = _auth.currentUser;

      // Notify listeners
      notifyListeners();

      // You can store additional user data in Firebase Firestore or Realtime Database here
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update loggedInUser with name and mobile number
      _loggedInUser = _auth.currentUser;

      // Notify listeners
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();

      // Reset loggedInUser
      _loggedInUser = null;

      // Notify listeners
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
