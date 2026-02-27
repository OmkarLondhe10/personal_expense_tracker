import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/features/transaction/presentation/screen/add_transaction_screen.dart';
import 'package:personal_expense_tracker/features/transaction/presentation/providers/transaction_provider.dart';
import 'package:personal_expense_tracker/features/transaction/presentation/widget/transaction_tile.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final transactions = provider.transactions;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        centerTitle: true,
      ),

      body: transactions.isEmpty
          ? _buildEmptyState(context)
          : RefreshIndicator(
              onRefresh: () async {
                await provider.load();
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final tx = transactions[index];

                  return Padding(
                    padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Dismissible(
                      key: ValueKey(tx.id),
                      direction: DismissDirection.endToStart,

                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.centerRight,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),

                      confirmDismiss: (_) async {
                        return await showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Delete Transaction?"),
                            content: const Text(
                                "This action cannot be undone."
                          ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(ctx, false),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(ctx, true),
                                child: const Text(
                                  "Delete",
                                  style:
                                      TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },

                      onDismissed: (_) async {
                        final removedTx = tx;
                        final provider =
                            context.read<TransactionProvider>();

                        await provider.delete(index);

                        ScaffoldMessenger.of(context)
                          .clearSnackBars();

                        ScaffoldMessenger.of(context)
                          .showSnackBar(
                          SnackBar(
                            content:
                                const Text("Transaction deleted"),
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              label: "UNDO",
                              onPressed: () async {
                                await provider.add(removedTx);
                              },
                            ),
                          ),
                        );
                      },

                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AddTransactionScreen(
                                      transaction: tx),
                            ),
                          );
                        },
                        child:
                            TransactionTile(transaction: tx),
                      ),
                    ),
                  );
                },
              ),
            ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddTransactionScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
    );
  }

  /// EMPTY STATE WIDGET
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long,
              size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            "No Transactions Yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Tap the + button to add one",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
