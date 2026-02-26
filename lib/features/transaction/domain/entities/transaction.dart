class Transaction {
  final int id;
  final double amount;
  final String category;
  final DateTime date;
  final bool isIncome;

  Transaction({
    required this.id, 
    required this.amount, 
    required this.category, 
    required this.date, 
    required this.isIncome,
  });
}