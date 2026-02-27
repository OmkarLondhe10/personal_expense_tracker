import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/features/budget/domain/usecase/get_budget.dart';
import 'package:personal_expense_tracker/features/budget/domain/usecase/set_budget.dart';

class BudgetProvider extends ChangeNotifier {

  final GetBudget getBudgetUseCase;
  final SetBudget setBudgetUseCase;

  BudgetProvider({
    required this.getBudgetUseCase,
    required this.setBudgetUseCase,
  });

  double _monthlyBudget = 0;

  double get monthlyBudget => _monthlyBudget;

  Future<void> load() async {
    final budget = await getBudgetUseCase();
    _monthlyBudget = budget.monthlyBudget;
    notifyListeners();
  }

  Future<void> setBudget(double amount) async {
    await setBudgetUseCase;
    _monthlyBudget = amount;
    notifyListeners();
  }

  double calculateRemaining({
    required double income,
    required double expense,
  }) {
    final totalAvailable = _monthlyBudget + income;
    return (totalAvailable - expense)
        .clamp(0, totalAvailable);
  }

  double calculateProgress(double expense) {
    if (_monthlyBudget == 0) return 0;
    return (expense / _monthlyBudget)
        .clamp(0, 1);
  }
}