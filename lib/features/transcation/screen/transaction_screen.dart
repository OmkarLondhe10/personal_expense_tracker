import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/features/transcation/screen/add_transaction_screen.dart';
import 'package:personal_expense_tracker/features/transcation/widget/transaction_tile.dart';
import 'package:personal_expense_tracker/provider/transaction_provider.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<TransactionProvider>(); 
    final transactions = provider.transactions;

    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
        body: transactions.isEmpty ? Center(child: Text("No Transactions Yet"),
        ) : ListView.builder(
          itemCount: transactions.length,

          itemBuilder: (context,index){
          final tx = transactions[index];

          return Dismissible(
            key: ValueKey(tx.id), 
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: Colors.red,
            child: Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) {
                context.read<TransactionProvider>().deleteTransaction(tx.id);
              },

              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_)=> AddTransactionScreen(transaction: tx),
                    ),
                  );
                },
                child: TransactionTile(transaction: tx),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=> AddTransactionScreen(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      );
    // );
  }
}