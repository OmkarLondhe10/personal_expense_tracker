import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/features/transcation/data/mock_transaction.dart';
import 'package:personal_expense_tracker/features/transcation/screen/add_transaction_screen.dart';
import 'package:personal_expense_tracker/features/transcation/widget/transaction_tile.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body: ListView.builder(
        itemCount: mocktransaction.length,
        itemBuilder: (context, index){
          final tx = mocktransaction[index];
          return TransactionTile(transaction: tx);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=> AddTransactionScreen()));
          },
          child: const Icon(Icons.add),
          ),
    );
  }
}