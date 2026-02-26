import 'package:personal_expense_tracker/features/transaction/data/models/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TransactionLocalDatasource {
  Future <List<TransactionModel>> loadTransactions();
  Future<void> saveTransaction(List<TransactionModel> transcations);
}

class TransactionLocalDatasourceImpl implements TransactionLocalDatasource {

  static const String _storagekey = 'transactions';

  @override
  Future<List<TransactionModel>> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_storagekey);

    if(data == null) return [];

    return data.map((e)=> TransactionModel.fromJson(e)).toList();
}

  @override
  Future<void> saveTransaction(List<TransactionModel> transcations) async{
    final prefs = await SharedPreferences.getInstance();
    final data = transcations.map((e)=> e.toJson()).toList();

    await prefs.setStringList(_storagekey, data);    
  }
}