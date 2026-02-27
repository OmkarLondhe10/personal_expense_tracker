import 'package:personal_expense_tracker/features/budget/domain/entities/budget_entity.dart';

class BudgetModel extends Budget{
  BudgetModel({required super.monthlyBudget});

  factory BudgetModel.fromDouble(double value){
    return BudgetModel(monthlyBudget: value);
  }
}