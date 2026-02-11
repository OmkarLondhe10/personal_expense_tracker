import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/provider/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'core/widgets/main_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> TransactionProvider())
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
      
        home: const MainNavigation(),
      ),
    );
  }
}
