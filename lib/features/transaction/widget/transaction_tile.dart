import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/features/transaction/domain/entities/transaction.dart';

class TransactionTile extends StatefulWidget {
  final Transaction transaction;

  const TransactionTile({
    super.key, 
    required this.transaction
    });

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  @override
  Widget build(BuildContext context) {
    final color = widget.transaction.isIncome ? Colors.green : Colors.red; 
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(
          widget.transaction.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
          color: color,
        ),
      ),

      title: Text(widget.transaction.category),
      subtitle: Text(
        DateFormat.yMMMd().format(widget.transaction.date),
      ),
      trailing: Text(
        '${widget.transaction.isIncome ? '+' : '-'}\$${widget.transaction.amount}',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}