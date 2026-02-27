import 'package:personal_expense_tracker/features/budget/domain/entities/budget_entity.dart';
import 'package:personal_expense_tracker/features/budget/domain/repositories/budget_repository.dart';

class GetBudget {
  final BudgetRepository repository;

  GetBudget(this.repository);

  Future<Budget> call() async{
    return await repository.getBudget();
  }
}