import 'package:personal_expense_tracker/features/transaction/domain/entities/transaction.dart';

class DashboardSummary {
  final double totalIncome;
  final double totalExpense;
  final double balance;
  final double budget;
  final double remaining;
  final List <Transaction> recentTransactions;

  DashboardSummary({
  required this.totalIncome, 
  required this.totalExpense, 
  required this.balance, 
  required this.budget, 
  required this.remaining,
  required this.recentTransactions, 
  });
}