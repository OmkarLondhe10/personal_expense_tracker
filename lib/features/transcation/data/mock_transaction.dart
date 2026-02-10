import 'package:personal_expense_tracker/models/transaction_model.dart';

final mocktransaction = [
  TransactionModel(id: 1, amount: 25, category: 'Food', date: DateTime.now(), note: 'Lunch', isIncome: false),
  TransactionModel(id: 2, amount: 1200, category: 'Salary', date: DateTime.now(), note: 'Company', isIncome: true),
  TransactionModel(id: 3, amount: 60, category: 'Transport', date: DateTime.now(), note: 'Taxi', isIncome: false),
];