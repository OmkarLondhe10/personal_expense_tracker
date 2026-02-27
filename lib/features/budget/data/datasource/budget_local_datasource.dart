import 'package:shared_preferences/shared_preferences.dart';

abstract class BudgetLocalDatasource {
  Future<double> getBudget();
  Future<void> setBudget(double amount);
}

class BudgetLocalDatasourceImpl implements BudgetLocalDatasource{
  static const _key = 'monthly_budget';
  
  @override
  Future<double> getBudget() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_key) ?? 0;
  }

  @override
  Future<void> setBudget(double amount) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_key, amount);
  }
}