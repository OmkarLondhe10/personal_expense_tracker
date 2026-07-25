import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_expense_tracker/features/auth/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _loading = false;

  bool get loading => _loading;

  User? get currentUser => _authService.currentUser;

  Stream<User?> get authStateChanges =>
      _authService.authStateChanges;

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);

      await _authService.login(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);

      await _authService.signUp(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}