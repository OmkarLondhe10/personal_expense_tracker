import 'package:personal_expense_tracker/features/budget/domain/repositories/budget_repository.dart';
import 'package:personal_expense_tracker/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:personal_expense_tracker/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:personal_expense_tracker/features/transaction/domain/repositories/transaction_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {

  final TransactionRepository transactionRepository;
  final BudgetRepository budgetRepository;

  DashboardRepositoryImpl({required this.transactionRepository, required this.budgetRepository});

  @override
  Future<DashboardSummary> getSummary() async{
    final transactions = await transactionRepository.getTransaction();
    final budget = await budgetRepository.getBudget();

    double income = 0;
    double expense = 0;

    for(var tx in transactions){
      if(tx.isIncome){
        income += tx.amount;
      } else {
        expense += tx.amount;
      }
    }

    final balance = income - expense;
    final totalAvaliable = budget.monthlyBudget + income;
    final remaining = ((totalAvaliable - expense).clamp(0.0, totalAvaliable)).toDouble();
    final recent = transactions.take(50).toList();

  return DashboardSummary(
    totalIncome: income, 
    totalExpense: expense, 
    balance: balance, 
    budget: budget.monthlyBudget, 
    remaining: remaining, 
    recentTransactions: recent,
    );
  }
}