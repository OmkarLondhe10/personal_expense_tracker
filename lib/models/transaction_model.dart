import 'dart:convert';

class TransactionModel {
  final int id;
  final double amount;
  final String category;
  final DateTime date;
  final String note;
  final bool isIncome;

  TransactionModel({
    required this.id, 
    required this.amount, 
    required this.category, 
    required this.date, 
    required this.note, 
    required this.isIncome
    });

Map<String, dynamic> toMap(){
  return{
    'id':id,
    'amount':amount,
    'category': category,
    'date': date.toIso8601String(),
    'note': note,
    'isIncome': isIncome,
  };
}

factory TransactionModel.fromMap(Map<String, dynamic> map) {
  return TransactionModel(
    id: map['id'] ?? 0,
    amount: (map['amount'] ?? 0).toDouble(),
    category: map['category'] ?? '',
    date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
    note: map['note'] ?? '',
    isIncome: map['isIncome'] ?? false,
  );
}

String toJson ()=> json.encode(toMap());
  factory TransactionModel.fromJson(String source) => TransactionModel.fromMap(json.decode(source));
}