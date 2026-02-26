import 'package:personal_expense_tracker/features/transaction/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(Transaction transaction);
  Future<List<Transaction>> getTransaction();
  Future <void> deleteTransaction(int id);
  Future<void> updateTransaction(Transaction transaction);
}