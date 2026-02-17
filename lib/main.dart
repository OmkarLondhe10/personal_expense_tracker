import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/core/navigation/app_routes.dart';
import 'package:personal_expense_tracker/core/widgets/main_navigation.dart';
import 'package:personal_expense_tracker/features/auth/auth_gate.dart';
import 'package:personal_expense_tracker/features/auth/login_screen.dart';
import 'package:personal_expense_tracker/features/auth/signup_screen.dart';
import 'package:personal_expense_tracker/features/transcation/screen/add_transaction_screen.dart';
import 'package:personal_expense_tracker/provider/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = TransactionProvider();
            provider.load();
            return provider;
          })
      ],
      
      child: MaterialApp(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: Colors.grey[50],
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
          ),
        ),
        initialRoute: AppRoutes.login,
        home: const AuthGate(),
        routes: {
        AppRoutes.home: (_) => const MainNavigation(),
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.signup: (_) => const SignupScreen(),   
        AppRoutes.addTransaction: (_)=> const AddTransactionScreen(),
        },
      ),
    );
  }
}
