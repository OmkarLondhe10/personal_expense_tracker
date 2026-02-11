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
  final _noteController = TextEditingController();
  
  bool isIncome = false;
  String category = 'Food';
  DateTime selectedDate = DateTime.now();

  @override
  void initState(){
    super.initState();

  final tx = widget.transaction;
  if(tx != null){

    _amountController.text = tx.amount.toString();
    _noteController.text = tx.note;

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
              decoration: InputDecoration(
                labelText: 'Amount'
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

          DropdownButtonFormField(
            value: category,
            items: const[
              DropdownMenuItem( value: 'Food', child: Text("Food")),
              DropdownMenuItem( value: 'Transport', child: Text("Transport")),
              DropdownMenuItem( value: 'Bills', child: Text("Bills")),
              DropdownMenuItem( value: 'Shopping', child: Text("Shopping")),
              DropdownMenuItem( value: 'Other', child: Text("Other")),
            ], 
            onChanged: (value){
              setState(() {
                category = value!;
                });
              }
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Note',
              ),
            ),

            const Spacer(),

            SizedBox(
              width: 80,
              child: ElevatedButton(
                onPressed: (){
              final amount = double.tryParse(_amountController.text);
              if (amount == null) return;
            
            if(widget.transaction == null ) {

            final tx = TransactionModel(
              id: DateTime.now().microsecondsSinceEpoch, 
              amount: amount, 
              category: category, 
              date: selectedDate, 
              note: _noteController.text, 
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
                  note: _noteController.text, 
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
}