import 'package:personal_expense_tracker/features/transaction/data/datasources/transaction_local_datasource.dart';
import 'package:personal_expense_tracker/features/transaction/data/models/transaction_model.dart';
import 'package:personal_expense_tracker/features/transaction/domain/entities/transaction.dart';
import 'package:personal_expense_tracker/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository{
  final TransactionLocalDatasource localDatasource;
  TransactionRepositoryImpl(this.localDatasource);
  
  @override
  Future<void> addTransaction(Transaction transaction) async {
    await localDatasource.loadTransactions();
  }

  @override
  Future<void> deleteTransaction(int id) async {
    final current = await localDatasource.loadTransactions();
    current.removeWhere((t)=> t.id == id);
    await localDatasource.saveTransaction(current);
  }

  @override
  Future<List<Transaction>> getTransaction() async{
    return await localDatasource.loadTransactions();
  }
  
  @override
  Future<void> updateTransaction(Transaction transaction) async{
    final current = await localDatasource.loadTransactions();
    final index = current.indexWhere((t)=> t.id == transaction.id);

    if (index != -1){
      current[index] = TransactionModel.fromEntity(transaction);
      await localDatasource.saveTransaction(current);
    }
  }
}