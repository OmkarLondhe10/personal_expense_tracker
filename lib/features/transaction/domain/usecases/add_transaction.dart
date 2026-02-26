import 'package:personal_expense_tracker/features/transaction/domain/entities/transaction.dart';
import 'package:personal_expense_tracker/features/transaction/domain/repositories/transaction_repository.dart';

class AddTransaction {
  final TransactionRepository repository;

  AddTransaction(this.repository);

  void call(Transaction transaction) async{
    await repository.addTransaction(transaction);
  }
}
