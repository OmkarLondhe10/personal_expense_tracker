import 'dart:convert';
import 'package:personal_expense_tracker/features/transaction/domain/entities/transaction.dart';

class TransactionModel extends Transaction{

  TransactionModel({
    required super.id, 
    required super.amount, 
    required super.category, 
    required super.date, 
    required super.isIncome
  });

  factory TransactionModel.fromEntity(Transaction transaction){
    return TransactionModel(
      id: transaction.id, 
      amount: transaction.amount, 
      category: transaction.category, 
      date: transaction.date, 
      isIncome: transaction.isIncome,
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'id' : id,
      'amount' : amount,
      'category' : category,
      'date' : date.toIso8601String(),
      'isIncome' : isIncome,
    };
  }

  factory TransactionModel.fromMap(Map<String,dynamic> map){
    return TransactionModel(
      id: map['id'] ?? 0, 
      amount: (map['amount'] ?? 0).toDouble(), 
      category: map['category'] ?? '',
      date: DateTime.tryParse(map['date']?? '') ?? DateTime.now(), 
      isIncome: map['isIncome'] ?? false,
    );
  }

  String toJson()=> json.encode(toMap());

  factory TransactionModel.fromJson(String source) => 
  TransactionModel.fromMap(json.decode(source));
}