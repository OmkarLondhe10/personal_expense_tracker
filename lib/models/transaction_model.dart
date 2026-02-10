class TransactionModel {
  
  final int id;
  final double amount;
  final String category;
  final DateTime date;
  final String note;
  final bool isIncome;

  TransactionModel({
    required this.id, 
    required this.amount, 
    required this.category, 
    required this.date, 
    required this.note, 
    required this.isIncome
    });
}