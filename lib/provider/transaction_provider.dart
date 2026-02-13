import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionProvider extends ChangeNotifier{
final List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  void addTransaction(TransactionModel tx){
    _transactions.insert(0, tx);
    notifyListeners();
  }

  void deleteTransaction(int id){
    _transactions.removeWhere((t)=> t.id == id);
  }

  void updateTransaction(TransactionModel updated){
    final index = _transactions.indexWhere((t)=> t.id == updated.id);
    if(index != -1){
      _transactions[index]=updated;
      notifyListeners();
    }
  }
}