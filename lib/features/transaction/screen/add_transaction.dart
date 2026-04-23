import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/models/transaction_model.dart';
import 'package:personal_expense_tracker/provider/transaction_provider.dart';
import 'package:provider/provider.dart';

class AddTransactionScreen extends StatefulWidget {
  final TransactionModel? transaction;

  const AddTransactionScreen({super.key, this.transaction});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _amountController = TextEditingController();

  late List<String> categories;
  bool isIncome = false;
  String category = 'Food';

  @override
  void initState(){
    super.initState();

    categories = [
      'Food',
      'Transport',
      'Bills',
      'Shopping',
      'Other'
    ];
  
      final tx = widget.transaction;
  
      if(tx != null){
        _amountController.text = tx.amount.toString();
        isIncome = tx.isIncome;
        category = tx.category;
  
    if(!categories.contains(category)){
      categories.add(category);
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.transaction == null ? 'Add Transaction' : 'Edit Transaction',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding:  const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Amount',
                prefixText: '₹',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                // color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                value: isIncome,
                title: Text(isIncome ? 'Income' : 'Expense'),
                secondary: Icon(
                  isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isIncome? Colors.green : Colors.red,
                ),
                onChanged: (value) {
                  setState(() {
                    isIncome = value; 
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: category,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: categories.map((cat){
                return DropdownMenuItem<String>(
                  value: cat,
                  child: Text(cat),
                  );
              }).toList(), 
              onChanged: (value) async {
                if(value == 'Other'){
                  final customCategory = await _showCategoryDialog();

                  if(customCategory != null && customCategory.isNotEmpty){
                    setState(() {
                      if(!categories.contains(customCategory)){
                        categories.insert(0, customCategory);
                      }
                      category = customCategory;
                    });
                  }
                    else{
                      setState(() {
                        category = value!;
                      });
                    }
                }
              }
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final amount =
                      double.tryParse(_amountController.text);
                  if (amount == null) return;

                  if (widget.transaction == null) {
                    final tx = TransactionModel(
                      id: DateTime.now()
                          .microsecondsSinceEpoch,
                      amount: amount,
                      category: category,
                      date: DateTime.now(),
                      isIncome: isIncome,
                    );

                    context
                        .read<TransactionProvider>()
                        .addTransaction(tx);
                  } else {
                    final updated = TransactionModel(
                      id: widget.transaction!.id,
                      amount: amount,
                      category: category,
                      isIncome: isIncome,
                      date: DateTime.now()
                    );

                    context
                        .read<TransactionProvider>()
                        .updateTransaction(updated);
                  }

                  Navigator.pop(context);
                },

                child: const Text(
                  "Save Transaction",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showCategoryDialog() async {
    final controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('Add Category'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'E.g: Salary, Freelance',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
