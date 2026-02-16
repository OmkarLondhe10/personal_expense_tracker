import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/provider/transaction_provider.dart';
import 'package:provider/provider.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  // final controller = TextEditingController(
  //   text: budget == 0 '': budget.toString(),
  // );
  
  @override
  Widget build(BuildContext context) {

    final provider = context.watch<TransactionProvider>();

    final budget = provider.monthlyBudget;
    final spent = provider.spent;
    final remaining = provider.remaining;
    final progress = provider.progress;

    final controller = TextEditingController(
      text:  budget == 0 ? '' : budget.toString(),
    );

    Color color;
    if(progress<0.5){
      color = Colors.green;
    } else if (progress < 0.8){
      color = Colors.orange;
    } else {
      color = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Budget'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Set Monthly budget',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
                        
            ElevatedButton(
              onPressed: (){
              final amount = double.tryParse(controller.text);
              if (amount != null){
                context.read<TransactionProvider>().setBudget(amount);
              }
              // FocusScope.of(context).unfocus();
            }, child: Text('Set')),

            const SizedBox(height: 20),
                        
            LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              color: color,
              backgroundColor: Colors.grey.shade300,
            ),
                        
            const SizedBox(height: 20),
                        
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Budget:\$${budget.toStringAsFixed(2)}'),
                    SizedBox(height: 6),
                    Text('Income:\$${provider.totalIncome.toStringAsFixed(2)}'),
                    SizedBox(height: 6),
                    Text('Spent: \$${spent.toStringAsFixed(2)}'),
                    SizedBox(height: 6),
                    Text('Remaining: \$${remaining.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}