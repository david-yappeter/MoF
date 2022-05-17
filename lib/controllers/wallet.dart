import 'package:get/get.dart';
import 'package:mof/database/helper.dart';
import 'package:mof/models/wallet.dart';

class WalletController extends GetxController {
  List<WalletModel> _wallets = [];

  List<WalletModel> get wallets => [..._wallets];

  Future<void> fetchAndSet() async {
    final dataList = await DBHelper.getData(DBHelper.walletDBName);
    _wallets = dataList
        .map(
          (e) => WalletModel(
            id: e['id'],
            name: e['name'],
            amount: e['amount'],
            iconId: e['icon_id'],
          ),
        )
        .toList();
  }

  Future<void> insert({
    required String name,
    required double amount,
    required int iconId,
  }) async {
    DBHelper.insert(DBHelper.walletDBName, {
      'name': name,
      'amount': amount,
      'iconId': iconId,
    });
  }
}
