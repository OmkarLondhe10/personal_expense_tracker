import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/features/transaction/screen/add_transaction.dart';
import 'package:personal_expense_tracker/features/transaction/widget/transaction_tile.dart';
import 'package:personal_expense_tracker/models/transaction_model.dart';
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
        title: const Text("Transactions"),
        centerTitle: true,
      ),

      body: transactions.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tx = transactions[index];
          
              // Check whether we need to show a new date header.
              final bool showDateHeader;
          
              if (index == 0) {
                showDateHeader = true;
              } else {
                final previousTx = transactions[index - 1];
          
                showDateHeader =
                    !_isSameDay(tx.date, previousTx.date);
              }
          
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
              // DATE HEADER
              if (showDateHeader)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                  16,
                  18,
                  16,
                  8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getDateLabel(tx.date),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          
                    Text(
                      "-₹${_getDailyTotal(
                        tx.date,
                        transactions,
                      ).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
          
                  // TRANSACTION
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Dismissible(
                      key: ValueKey(tx.id),
                      direction: DismissDirection.endToStart,
          
                      // DELETE BACKGROUND
                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
          
                      // DELETE CONFIRMATION
                      confirmDismiss: (_) async {
                        return await showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text(
                              "Delete Transaction?",
                            ),
                            content: const Text(
                              "This action cannot be undone.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx, false);
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx, true);
                                },
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
          
                      // DELETE TRANSACTION
                      onDismissed: (_) {
                        final removedTx = tx;
          
                        // Because our displayed list is sorted,
                        // use ID instead of index to delete.
                        provider.deleteTransaction(tx.id);
          
                        ScaffoldMessenger.of(context)
                            .clearSnackBars();
          
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          SnackBar(
                            content: const Text(
                              "Transaction deleted",
                            ),
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              label: "UNDO",
                              onPressed: () {
                                provider.addTransaction(
                                  removedTx,
                                );
                              },
                            ),
                          ),
                        );
                      },
          
                      // EDIT TRANSACTION
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AddTransactionScreen(
                                transaction: tx,
                              ),
                            ),
                          );
                        },
                        child: TransactionTile(
                          transaction: tx,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

      // ADD TRANSACTION
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddTransactionScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
    );
  }

  // Check whether two dates are the same calendar day.
  bool _isSameDay(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  double _getDailyTotal(
    DateTime date,
    List<TransactionModel> transactions,
  ) {
    return transactions
        .where(
          (tx) => _isSameDay(tx.date, date) && !tx.isIncome).
          fold(0.0, (sum, tx) => sum + tx.amount);
  }

  // Convert date into Today / Yesterday / actual date.
  String _getDateLabel(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final transactionDate = DateTime(
      date.year,
      date.month,
      date.day,
    );

    final yesterday = today.subtract(
      const Duration(days: 1),
    );

    if (transactionDate == today) {
      return "TODAY";
    }

    if (transactionDate == yesterday) {
      return "YESTERDAY";
    }

    return DateFormat('dd MMM yyyy')
        .format(date)
        .toUpperCase();
  }

  // EMPTY STATE
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 80,
            color: Colors.grey.shade400,
          ),
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
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}