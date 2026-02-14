import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/features/transcation/widget/transaction_tile.dart';
import 'package:personal_expense_tracker/provider/transaction_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<TransactionProvider>();

    final income = provider.totalIncome;
    final expense = provider.totalExpense;
    final balance = provider.balance;
    final recent = provider.recentTransactions;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashoard"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text("Balance", style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text('\$${balance.toStringAsFixed(2)}',style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(child: 
                Card(
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text('Income'),
                      SizedBox(height: 6),
                      Text('\$${income.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Card(
                  color: Colors.red.shade50,
                  child: Padding(padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text('Expense'),
                        const SizedBox(height: 6),
                        Text(
                          '\$${expense.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                              ),
                          ),
                        ],
                      ),
                    ),
                  )
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text('Recent Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

          if(recent.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text('No Transactions Yet'),
              ),
            )
            else...recent.map((e)=> TransactionTile(transaction: e)),
          ],
        ),
      ),
    );
  }
}