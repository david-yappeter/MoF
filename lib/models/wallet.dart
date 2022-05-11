class WalletModel {
  final int id;
  final String name;
  final double amount;
  final int? iconId;

  WalletModel({
    required this.id,
    required this.name,
    required this.amount,
    this.iconId,
  });
}
