import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/features/auth/domain/usecase/get_current_user.dart';
import 'package:personal_expense_tracker/features/auth/domain/usecase/login_user.dart';
import 'package:personal_expense_tracker/features/auth/domain/usecase/logout_user.dart';
import 'package:personal_expense_tracker/features/auth/domain/usecase/signup_user.dart';
import '../../domain/entities/user.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUser loginUser;
  final SignupUser signupUser;
  final LogoutUser logoutUser;
  final GetCurrentUser getCurrentUser;

  AuthProvider({
    required this.loginUser,
    required this.signupUser,
    required this.logoutUser,
    required this.getCurrentUser,
  });

  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;

  Future<void> checkAuth() async {
    _user = await getCurrentUser();
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    _user = await loginUser(email, password);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    _user = await signupUser(email, password);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await logoutUser();
    _user = null;
    notifyListeners();
  }
}