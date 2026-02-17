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

              confirmDismiss: (_) async {
                return await showDialog(
                  context: context, 
                  builder: (ctx) => AlertDialog(
                    title: const Text("Delete Transaction ?"),
                    content: const Text("This Cannot be Undone."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false) , 
                        child: const Text("Cancel")
                      ),
                      TextButton(
                        onPressed: ()=> Navigator.pop(ctx, true), 
                        child: const Text("Delete"),
                        ),
                    ],
                  )
                  );
              },
              
              onDismissed: (_) {

                final removedtx = tx;
                final removedIndex = index;
                final provider = context.read<TransactionProvider>(); 
                
                provider.deleteAt(index);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Transaction Deleted"),
                  action: SnackBarAction(
                    label: "Undo", 
                    onPressed: (){
                      provider.insertAt(removedIndex, removedtx);
                    }
                    ),
                  ),
                );
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
            Navigator.push(context, MaterialPageRoute(builder: (_)=> const AddTransactionScreen()),
              );
            },
        child: Icon(Icons.add),
      ),
    );
  }
}