import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/core/widgets/main_navigation.dart';
import 'package:personal_expense_tracker/features/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool? loggedIn;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final status = prefs.getBool('loggedIn') ?? false;

    setState(() {
      loggedIn = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(loggedIn == null){
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
        ),
      );
    }

    if(loggedIn == true){
      return const MainNavigation();
    }
      return const LoginScreen();
  }
}