import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:personal_expense_tracker/features/budget/presentation/provider/budget_provider.dart';
import 'package:personal_expense_tracker/features/transaction/presentation/providers/transaction_provider.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final budget =
        context.read<BudgetProvider>().monthlyBudget;

    _controller.text =
        budget == 0 ? '' : budget.toString();
  }

  @override
  Widget build(BuildContext context) {

    final transactionProvider =
        context.watch<TransactionProvider>();

    final budgetProvider =
        context.watch<BudgetProvider>();

    final budget = budgetProvider.monthlyBudget;
    final spent = transactionProvider.totalExpense;

    final remaining = budgetProvider.calculateRemaining(
      income: transactionProvider.totalIncome,
      expense: spent,
    );

    final progress =
        budgetProvider.calculateProgress(spent);

    final percentage =
        (progress * 100).toStringAsFixed(0);

    Color color;
    if (progress < 0.5) {
      color = Theme.of(context).colorScheme.primary;
    } else if (progress < 0.8) {
      color = Theme.of(context)
          .colorScheme
          .tertiaryContainer;
    } else {
      color = Theme.of(context).colorScheme.error;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Budget'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType:
                        TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Set Monthly Budget',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {
                    final amount =
                        double.tryParse(
                            _controller.text);

                    if (amount != null) {
                      context
                          .read<BudgetProvider>()
                          .setBudget(amount);

                      FocusScope.of(context)
                          .unfocus();
                    }
                  },
                  child: const Text('Set'),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "$percentage% used",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),

                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 14,
                    color: color,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    _infoRow("Budget", budget),
                    _infoRow(
                        "Income",
                        transactionProvider
                            .totalIncome),
                    _infoRow("Spent", spent),
                    const Divider(height: 20),
                    _infoRow(
                        "Remaining",
                        remaining,
                        bold: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, double value,
      {bool bold = false}) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            "\$${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: bold
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}