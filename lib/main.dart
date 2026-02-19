import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:personal_expense_tracker/core/navigation/app_routes.dart';
import 'package:personal_expense_tracker/core/widgets/main_navigation.dart' show MainNavigation;
import 'package:personal_expense_tracker/features/auth/auth_gate.dart';
import 'package:personal_expense_tracker/features/auth/login_screen.dart';
import 'package:personal_expense_tracker/features/auth/signup_screen.dart';
import 'package:personal_expense_tracker/features/transcation/screen/add_transaction_screen.dart';
import 'package:personal_expense_tracker/provider/app_settings_provider.dart';
import 'package:personal_expense_tracker/provider/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppSettingsProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettingsProvider>();

    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,

      home: const AuthGate(),

      routes: {
        AppRoutes.home: (_) => const MainNavigation(),
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.signup: (_) => const SignupScreen(),
        AppRoutes.addTransaction: (_) =>
            const AddTransactionScreen(),
      },

      themeMode:
          settings.darkmode ? ThemeMode.dark : ThemeMode.light,

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
    );
  }
}
