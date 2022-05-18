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

  static WalletModel parse(dynamic data) {
    return WalletModel(
      id: data['id'],
      name: data['name'],
      amount: data['amount'],
      iconId: data['icon_id'],
    );
  }
}
