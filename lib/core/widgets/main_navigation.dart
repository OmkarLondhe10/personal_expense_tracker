import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/features/budget/budget_screen.dart';
import 'package:personal_expense_tracker/features/dashboard/dashboard_screen.dart';
import 'package:personal_expense_tracker/features/profile/profile_screen.dart';
import 'package:personal_expense_tracker/features/transaction/presentation/screen/transaction_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;

  final List<Widget>_screens = const [
    DashboardScreen(),
    TransactionScreen(),
    BudgetScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected:(value) {
          setState(() {
            _index = value;
            },
          );
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.list), label: "Transaction"),
          NavigationDestination(icon: Icon(Icons.pie_chart), label: "Budget"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}