import 'package:get/get.dart';
import 'package:mof/database/helper.dart';
import 'package:mof/models/transaction.dart';

class TransactionController extends GetxController {
  RxList<dynamic> transactions = [].obs;

  // RxList<dynamic> get transactions => _transactions;

  Future<void> fetchAndSet() async {
    // final dataList = await DBHelper.getData(DBHelper.transactionDBName);
    final dataList = await DBHelper.rawQuery(
        'SELECT t.*, c.name as category_name, c.is_income as category_is_income FROM ${DBHelper.transactionDBName} as t INNER JOIN ${DBHelper.categoryDBName} as c ON t.category_id = c.id');
    transactions = RxList(dataList.map(
      (e) {
        return TransactionModel(
          id: e["id"],
          amount: e["amount"],
          categoryId: e["category_id"],
          walletId: e["wallet_id"],
          createdAt: DateTime.parse(e["created_at"]),
          updatedAt: DateTime.parse(e["updated_at"]),
          categoryIsIncome: e["category_is_income"] == 1,
          categoryName: e["category_name"],
          iconId: e["icon_id"],
        );
      },
    ).toList());
  }

  void add(TransactionModel transaction) {
    transactions.add(transaction);
  }
}
