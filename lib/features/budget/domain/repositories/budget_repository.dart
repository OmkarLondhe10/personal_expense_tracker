import 'package:personal_expense_tracker/features/budget/domain/entities/budget_entity.dart';

abstract class BudgetRepository {
  Future<Budget> getBudget();
  Future<void> setBudget(double amount);
}