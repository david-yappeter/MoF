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

  Future<int> insert({
    required String name,
    required double amount,
    int? iconId,
  }) {
    return DBHelper.insert(DBHelper.walletDBName, {
      'name': name,
      'amount': amount,
      'icon_id': iconId,
    });
  }

  WalletModel getById(int id) {
    return _wallets.firstWhere((e) => e.id == id);
  }

  // WalletModel getById(int id) {
  //   return DBHelper.rawQuery('''
  //   SELECT FROM * ${DBHelper.walletDBName} WHERE id = ${id}
  // ''');
  // }
}
