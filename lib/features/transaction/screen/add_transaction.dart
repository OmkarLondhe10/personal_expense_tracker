import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    categories = ['Food', 'Transport', 'Bills', 'Shopping', 'Other'];

    final tx = widget.transaction;

    if (tx != null) {
      _amountController.text = tx.amount.toString();
      isIncome = tx.isIncome;
      category = tx.category;
      selectedDate = tx.date;

      if (!categories.contains(category)) {
        categories.add(category);
      }
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(), // change this if you want to allow future dates
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);

    if (target == today) return 'Today';
    if (target == today.subtract(const Duration(days: 1))) return 'Yesterday';

    return DateFormat('dd MMM yyyy').format(date);
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
        padding: const EdgeInsets.all(16),
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

            // DATE PICKER FIELD
            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(12),
              child: InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatDate(selectedDate)),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                value: isIncome,
                title: Text(isIncome ? 'Income' : 'Expense'),
                secondary: Icon(
                  isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isIncome ? Colors.green : Colors.red,
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
              items: categories.map((cat) {
                return DropdownMenuItem<String>(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (value) async {
                if (value == 'Other') {
                  final customCategory = await _showCategoryDialog();

                  if (customCategory != null && customCategory.isNotEmpty) {
                    setState(() {
                      if (!categories.contains(customCategory)) {
                        categories.insert(0, customCategory);
                      }
                      category = customCategory;
                    });
                  } else {
                    setState(() {
                      category = value!;
                    });
                  }
                } else {
                  setState(() {
                    category = value!;
                  });
                }
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final amount = double.tryParse(_amountController.text);
                  if (amount == null) return;

                  if (widget.transaction == null) {
                    final tx = TransactionModel(
                      id: DateTime.now().microsecondsSinceEpoch,
                      amount: amount,
                      category: category,
                      date: selectedDate,
                      isIncome: isIncome,
                    );

                    context.read<TransactionProvider>().addTransaction(tx);
                  } else {
                    final updated = TransactionModel(
                      id: widget.transaction!.id,
                      amount: amount,
                      category: category,
                      isIncome: isIncome,
                      date: selectedDate,
                    );

                    context.read<TransactionProvider>().updateTransaction(
                      updated,
                    );
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
