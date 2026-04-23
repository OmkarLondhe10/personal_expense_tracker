import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/provider/transaction_provider.dart';
import 'package:provider/provider.dart';

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
  
    final budget = context.read<TransactionProvider>().monthlyBudget;

    _controller.text = budget == 0 ? '' : budget.toString();
}
  
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    
    final budget = provider.monthlyBudget;
    final spent = provider.spent;
    final remaining = provider.remaining;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Budget'),
        centerTitle: true,
        elevation: 0,
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
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Monthly Budget',
                      prefixText: '₹',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: (){
                    final amount = double.tryParse(_controller.text);
                      if (amount != null){
                        context.read<TransactionProvider>().setBudget(amount);
                        FocusScope.of(context).unfocus();
                      } 
                  }, 
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                  ),
                  child: Text('Set',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  ),
                  
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _infoRow("Budget",budget),
                  _infoRow("Income",provider.totalIncome),
                  _infoRow("Spent",spent),
                  
                  const Divider(color: Colors.white),
                  _infoRow("Remaining",remaining, bold: true),
                    ]
                  ))
                ],
              ),
            ),
          );
        }

Widget _infoRow(String label, double value,
      {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            "₹${value.toStringAsFixed(2)}",
            style: TextStyle(
              color: Colors.white,
              fontWeight:
                  bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
