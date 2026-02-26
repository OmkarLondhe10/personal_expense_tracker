import 'package:personal_expense_tracker/features/transaction/domain/entities/transaction.dart';
import 'package:personal_expense_tracker/features/transaction/domain/repositories/transaction_repository.dart';

class GetTransaction {
  final TransactionRepository repository;

  GetTransaction(this.repository);

  Future<List<Transaction>> call() async{
    return await repository.getTransaction();
  }
}