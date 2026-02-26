import 'package:personal_expense_tracker/features/transaction/domain/entities/transaction.dart';
import 'package:personal_expense_tracker/features/transaction/domain/repositories/transaction_repository.dart';

class UpdateTransaction {
  final TransactionRepository repository;

  UpdateTransaction(this.repository);

  Future<void> call(Transaction transaction) async {
    await repository.updateTransaction(transaction);
  }
}