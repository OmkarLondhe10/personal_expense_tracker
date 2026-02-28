import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/features/auth/presentation/screens/login_screen.dart';
import 'package:personal_expense_tracker/features/auth/presentation/screens/signup_screen.dart';
import 'package:personal_expense_tracker/features/transaction/presentation/screen/add_transaction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_routes.dart';
import '../../core/widgets/main_navigation.dart';


class AppRouter {
  static Future <Route> generate(RouteSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('loggedIn') ?? false ;

    if (!loggedIn && settings.name != AppRoutes.login && settings.name != AppRoutes.signup){
      return MaterialPageRoute(builder: (_)=> const LoginScreen());
    }
    switch (settings.name) {
    
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const MainNavigation(),
        );

    case AppRoutes.signup:
    return MaterialPageRoute(builder: (_)=> const SignupScreen());

    case AppRoutes.login:
    return MaterialPageRoute(builder: (_)=> const LoginScreen());

      case AppRoutes.addTransaction:
        final tx = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => AddTransactionScreen(
            transaction: tx as dynamic,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('404 – Route not found'),
            ),
          ),
        );
    }
  }
}
