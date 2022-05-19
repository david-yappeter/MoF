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

  // WalletModel getById(int id) {
  //   return _wallets.firstWhere((e) => e.id == id);
  // }

  Future<List<Map<String, dynamic>>> getById(int id) async {
    return DBHelper.rawQuery('''
    SELECT * FROM ${DBHelper.walletDBName} WHERE id = $id LIMIT 1
  ''');
  }

  Future<void> updateAmount({
    required int walletId,
    required double amount,
  }) async {
    final sqlDb = await DBHelper.database();
    return sqlDb.execute('''
    UPDATE ${DBHelper.walletDBName}
    SET amount = amount + $amount
    WHERE id = $walletId
  ''');
  }
}
