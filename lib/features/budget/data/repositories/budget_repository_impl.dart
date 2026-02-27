import 'package:personal_expense_tracker/features/budget/data/datasource/budget_local_datasource.dart';
import 'package:personal_expense_tracker/features/budget/domain/entities/budget_entity.dart';
import 'package:personal_expense_tracker/features/budget/domain/repositories/budget_repository.dart';

class BudgetRepositoryImpl implements BudgetRepository{

  final BudgetLocalDatasource localDatasource;

  BudgetRepositoryImpl(this.localDatasource);

  @override
  Future<Budget> getBudget() async {
    final value = await localDatasource.getBudget();
    return Budget(monthlyBudget: value);
  }

  @override
  Future<void> setBudget(double amount) async {
    await localDatasource.setBudget(amount);
  }
}