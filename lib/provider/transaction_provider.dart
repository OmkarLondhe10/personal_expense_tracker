import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction_model.dart';

class TransactionProvider extends ChangeNotifier{
final List<TransactionModel> _transactions = [];
static const _storagekey = 'transactions';

  List<TransactionModel> get transactions => _transactions;

  void addTransaction(TransactionModel tx){
    _transactions.insert(0, tx);
    _save();
    notifyListeners();
  }

  void deleteTransaction(int id){
    _transactions.removeWhere((t)=> t.id == id);
    _save();
  }

  void updateTransaction(TransactionModel updated){
    final index = _transactions.indexWhere((t)=> t.id == updated.id);
    if(index != -1){
      _transactions[index]=updated;
      _save();
      notifyListeners();
    }
  }

  void insertAt(int index, TransactionModel tx) {
    _transactions.insert(index, tx);
    _save();
    notifyListeners();
  }

  void deleteAt(int index) {
    _transactions.removeAt(index);
    _save();
    notifyListeners();
  }

  
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_storagekey);

  if (data != null){
    _transactions.clear();
    _transactions.addAll(
      data.map((e) => TransactionModel.fromJson((e).toString()),
      )
    );
  notifyListeners();
  }
}

Future<void> _save() async{
  final prefs = await SharedPreferences.getInstance();
  final data = _transactions.map((e)=> e.toJson()).toList();
  await prefs.setStringList(_storagekey, data);
  }

double get totalIncome => 
  _transactions.where((t)=> t.isIncome).fold(0, (sum,t)=>sum+t.amount);

double get totalExpense =>
_transactions.where((t)=> !t.isIncome).fold(0, (sum,t)=> sum+t.amount);

double get balance => totalIncome - totalExpense;

List<TransactionModel> get recentTransactions => _transactions.take(10).toList();
}