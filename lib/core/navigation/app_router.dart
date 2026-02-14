import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/features/transcation/screen/add_transaction_screen.dart';
import 'app_routes.dart';
import '../../core/widgets/main_navigation.dart';


class AppRouter {
  static Route<dynamic> generate(RouteSettings settings) {
  // print('ROUTE REQUESTED: ${settings.name}');
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const MainNavigation(),
        );

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
