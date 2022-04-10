class TransactionModel {
  final String id;
  final bool isExpense;
  final double amount;
  final String categoryId;

  const TransactionModel({
    required this.id,
    required this.isExpense,
    required this.amount,
    required this.categoryId,
  });
}
