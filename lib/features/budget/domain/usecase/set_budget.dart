import 'package:personal_expense_tracker/features/budget/domain/repositories/budget_repository.dart';

class SetBudget {
  final BudgetRepository repository;

  SetBudget(this.repository);

  Future<void> call(double amount) async {
    return await repository.setBudget(amount);
  }
}