import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Transaction"),
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
              child: ElevatedButton(onPressed: (){
                Navigator.pop(context);
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