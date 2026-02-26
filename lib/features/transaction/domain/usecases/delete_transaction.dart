import 'package:personal_expense_tracker/features/transaction/domain/repositories/transaction_repository.dart';


class DeleteTransaction {
  final TransactionRepository repository;

  DeleteTransaction(this.repository);

  Future<void> call(int id) async{
    await repository.deleteTransaction(id);
  }
}