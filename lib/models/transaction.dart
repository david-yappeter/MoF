class TransactionModel {
  final int id;
  final double amount;
  final int categoryId;
  final int walletId;
  final DateTime createdAt, updatedAt;
  final String categoryName;
  final bool categoryIsIncome;
  final int? iconId;

  const TransactionModel({
    required this.id,
    required this.amount,
    required this.categoryId,
    required this.walletId,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryName,
    required this.categoryIsIncome,
    this.iconId,
  });
}
