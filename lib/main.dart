import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/core/navigation/app_routes.dart';
import 'package:personal_expense_tracker/core/widgets/main_navigation.dart' show MainNavigation;
import 'package:personal_expense_tracker/features/auth/auth_gate.dart';
import 'package:personal_expense_tracker/features/auth/login_screen.dart';
import 'package:personal_expense_tracker/features/auth/signup_screen.dart';
import 'package:personal_expense_tracker/features/transaction/screen/add_transaction.dart';
import 'package:personal_expense_tracker/firebase_options.dart';
import 'package:personal_expense_tracker/provider/app_settings_provider.dart';
import 'package:personal_expense_tracker/provider/auth_provider.dart';
import 'package:personal_expense_tracker/provider/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppSettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
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
        AppRoutes.addTransaction: (_) => const AddTransactionScreen(),
      },

      themeMode:
          settings.darkmode ? ThemeMode.dark : ThemeMode.light,

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
    );
  }
}
