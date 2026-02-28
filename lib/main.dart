import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:personal_expense_tracker/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:personal_expense_tracker/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:personal_expense_tracker/features/auth/domain/usecase/get_current_user.dart';
import 'package:personal_expense_tracker/features/auth/domain/usecase/login_user.dart';
import 'package:personal_expense_tracker/features/auth/domain/usecase/logout_user.dart';
import 'package:personal_expense_tracker/features/auth/domain/usecase/signup_user.dart';
import 'package:personal_expense_tracker/features/auth/presentation/providers/auth_provider.dart';
import 'package:personal_expense_tracker/features/auth/presentation/screens/login_screen.dart';
import 'package:personal_expense_tracker/features/auth/presentation/screens/signup_screen.dart';
import 'package:personal_expense_tracker/features/budget/data/datasource/budget_local_datasource.dart';
import 'package:personal_expense_tracker/features/budget/data/repositories/budget_repository_impl.dart';
import 'package:personal_expense_tracker/features/budget/domain/usecase/get_budget.dart';
import 'package:personal_expense_tracker/features/budget/domain/usecase/set_budget.dart';
import 'package:personal_expense_tracker/features/budget/presentation/provider/budget_provider.dart';
import 'package:personal_expense_tracker/features/transaction/domain/usecases/add_transaction.dart';
import 'package:personal_expense_tracker/features/transaction/domain/usecases/delete_transaction.dart';
import 'package:personal_expense_tracker/features/transaction/domain/usecases/get_transaction.dart';
import 'package:personal_expense_tracker/features/transaction/domain/usecases/update_transaction.dart';
import 'package:personal_expense_tracker/features/transaction/presentation/providers/app_settings_provider.dart';
import 'package:personal_expense_tracker/features/transaction/presentation/providers/transaction_provider.dart';
import 'package:personal_expense_tracker/features/transaction/presentation/screen/add_transaction_screen.dart';
import 'package:provider/provider.dart';

import 'core/navigation/app_routes.dart';
import 'core/widgets/main_navigation.dart';
import 'core/theme/app_theme.dart';

import 'features/auth/presentation/providers/auth_gate.dart';

import 'features/transaction/data/datasources/transaction_local_datasource.dart';
import 'features/transaction/data/repositories/transaction_repository_impl.dart';


void main() {
  setUrlStrategy(PathUrlStrategy());

  final localDataSource = TransactionLocalDatasourceImpl();
  final repository = TransactionRepositoryImpl(localDataSource);

  final addTransactionUseCase = AddTransaction(repository);
  final getTransactionsUseCase = GetTransaction(repository);
  final deleteTransactionUseCase = DeleteTransaction(repository);
  final updateTransactionUseCase = UpdateTransaction(repository);

  final BudgetLocalDatasource = BudgetLocalDatasourceImpl();
  final BudgetRepository = BudgetRepositoryImpl(BudgetLocalDatasource);
  final getBudgetUseCase = GetBudget(BudgetRepository);
  final setBudgetUseCase = SetBudget(BudgetRepository);

  final authLocalDataSource = AuthLocalDatasourceImpl();
  final authRepository = AuthRepositoryImpl(authLocalDataSource);

  final loginUser = LoginUser(authRepository);
  final signupUser = SignupUser(authRepository);
  final logoutUser = LogoutUser(authRepository);
  final getCurrentUser = GetCurrentUser(authRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(
            addTransactionUseCase: addTransactionUseCase,
            getTransactionsUseCase: getTransactionsUseCase,
            deleteTransactionUseCase: deleteTransactionUseCase,
            updateTransactionUsecase: updateTransactionUseCase,
          )..load(),
        ),

    ChangeNotifierProvider(
      create: (_) => AuthProvider(
        loginUser: loginUser,
        signupUser: signupUser,
        logoutUser: logoutUser,
        getCurrentUser: getCurrentUser,
      )..checkAuth(),
    ),

        ChangeNotifierProvider(
          create: (_)=> BudgetProvider(
            getBudgetUseCase: getBudgetUseCase, 
            setBudgetUseCase: setBudgetUseCase
          ),
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