import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/features/transaction/domain/usecases/get_transaction.dart';
import 'package:personal_expense_tracker/features/transaction/domain/usecases/update_transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/add_transaction.dart';
import '../../domain/usecases/delete_transaction.dart';

class TransactionProvider extends ChangeNotifier {
  final AddTransaction addTransactionUseCase;
  final GetTransaction getTransactionsUseCase;
  final DeleteTransaction deleteTransactionUseCase;
  final UpdateTransaction updateTransactionUsecase;

  TransactionProvider({
    required this.updateTransactionUsecase,
    required this.addTransactionUseCase,
    required this.getTransactionsUseCase,
    required this.deleteTransactionUseCase,
  }) {
    _loadMonthlyBudget();
  }

  List<Transaction> _transactions = [];
  List<Transaction> get transactions => _transactions;

  double _monthlyBudget = 0;
  double get monthlyBudget => _monthlyBudget;

  double get spent => totalExpense;
  
  double get remaining => _monthlyBudget - spent;
  
  double get progress {
    if (_monthlyBudget <= 0) return 0;
    return (spent / _monthlyBudget).clamp(0, 1);
  }

  Future<void> load() async {
    _transactions = await getTransactionsUseCase();
    notifyListeners();
  }

  Future<void> add(Transaction tx) async {
    addTransactionUseCase(tx);
    await load();
  }

  Future<void> delete(int id) async {
    await deleteTransactionUseCase(id);
    await load();
  }

  double get totalIncome =>
      _transactions.where((t) => t.isIncome)
          .fold(0, (sum, t) => sum + t.amount);

  double get totalExpense =>
      _transactions.where((t) => !t.isIncome)
          .fold(0, (sum, t) => sum + t.amount);

  double get balance => totalIncome - totalExpense;

  List<Transaction> get recentTransactions =>
      _transactions.take(100).toList();

  void setBudget(double amount) {
    _monthlyBudget = amount;
    _saveMonthlyBudget();
    notifyListeners();
  }

  Future<void> _loadMonthlyBudget() async {
    final prefs = await SharedPreferences.getInstance();
    _monthlyBudget = prefs.getDouble('monthly_budget') ?? 0;
  }

  Future<void> _saveMonthlyBudget() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('monthly_budget', _monthlyBudget);
  }
}