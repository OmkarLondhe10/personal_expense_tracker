import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Current User
  User? get currentUser => _auth.currentUser;

  // Auth State
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign Up
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // Login
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Forgot Password
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(
      email: email.trim(),
    );
  }
}