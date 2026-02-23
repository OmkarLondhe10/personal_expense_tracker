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
  late List <String> categories;

  
  bool isIncome = false;
  String category = 'Food';
  DateTime selectedDate = DateTime.now();

  @override
  void initState(){
    super.initState();

    categories = [
      'Food',
      'Transport',
      'Bills',
      'Shopping',
      'Other',
    ];

  final tx = widget.transaction;

  if(tx != null){{
    category = tx.category;

    if(!categories.contains(category)){
      categories.add(category);
    }
  }

    _amountController.text = tx.amount.toString();

    isIncome = tx.isIncome;
    category = tx.category;
    selectedDate = tx.date;
  }
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.transaction == null ? 'Add Transaction' :'Edit Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              cursorColor: Theme.of(context).colorScheme.shadow,
              decoration: InputDecoration(
                hintText: 'Amount',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

          SwitchListTile(
            value: isIncome, 
            title: Text(isIncome? 'Income' : 'Expense'),
            onChanged: (value){
            setState(() {
              isIncome = value;
                  }
                );         
              }
            ),
            
            const SizedBox(height: 10),

          DropdownButtonFormField<String>(
            value: category,
            items: categories.map((cat){
              return DropdownMenuItem<String>(
                value: cat,
                child: Text(cat),
              );
            }).toList(), 
            onChanged: (value) async{
              if (value == 'Other'){
                final customCategory = await _showCategoryDialog();

                if(customCategory != null && customCategory.isNotEmpty){
                  setState(() {
                    if(!categories.contains(customCategory)){
                      categories.insert(
                        0, customCategory,
                      );
                    }
                    category = customCategory;
                  });
                }
                else {
                  setState(() {
                    category = value!;
                  });
                }
              }
            } 
          ),


            const SizedBox(height: 10),

            const Spacer(),

            SizedBox(
              width: 80,
              child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.tertiary,
                ),
              ),
            onPressed: (){
              final amount = double.tryParse(_amountController.text);
              if (amount == null) return;
            
            if(widget.transaction == null ) {

            final tx = TransactionModel(
              id: DateTime.now().microsecondsSinceEpoch, 
              amount: amount, 
              category: category, 
              date: selectedDate, 

              isIncome: isIncome
            );
              context.read<TransactionProvider>().addTransaction(tx);
              Navigator.pop(context);
              } 
              else 
              {
                final updated = TransactionModel(
                  id: widget.transaction!.id, 
                  amount: amount, 
                  category: category, 
                  date: selectedDate, 

                  isIncome: isIncome
                  );
              context.read<TransactionProvider>().updateTransaction(updated);
              } 
            if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
            child: Text("Save")
              ),
            )
          ],
        ),
      ),
    );
  }
  
  Future<String?> _showCategoryDialog() async {
    final controller = TextEditingController();

    return showDialog<String>(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text('Enter Custom Category'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'E.g: Salary, Freelance, Gift',
            ),
          ),
          actions: [
            TextButton(onPressed: ()=> Navigator.pop(context), 
            child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.tertiary,
                ),
              ),
              onPressed: (){
              Navigator.pop(context,controller.text);
            }, 
            child: const Text('Save')
            ),
          ],
        );
      }
    );
  }
}