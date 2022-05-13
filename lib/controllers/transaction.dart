import 'package:get/get.dart';
import 'package:mof/controllers/custom_tab_bar.dart';
import 'package:mof/database/helper.dart';
import 'package:mof/models/transaction.dart';

class TransactionController extends GetxController {
  RxList<dynamic> transactions = [].obs;
  RxDouble totalInflow = 0.0.obs;
  RxDouble totalOutflow = 0.0.obs;

  Future<void> fetchAndSet({DateTime? startDate, DateTime? endDate}) async {
    final whereFilter = [];

    if (startDate != null) {
      whereFilter.add('t.created_at >= date(\'${startDate.toString()}\')');
    }
    if (endDate != null) {
      whereFilter.add(' t.created_at <= date(\'${endDate.toString()}\')');
    }

    final dataList = await DBHelper.rawQuery(
      '''
        SELECT t.*, c.name as category_name, c.is_income as category_is_income 
        FROM ${DBHelper.transactionDBName} as t 
        INNER JOIN ${DBHelper.categoryDBName} as c 
        ON t.category_id = c.id
        ${whereFilter.isNotEmpty ? 'WHERE ' : ''}
        ${whereFilter.join(' AND ')}
        ORDER BY t.created_at DESC
''',
    );

    transactions.clear();
    totalInflow.value = 0.0;
    totalOutflow.value = 0.0;

    transactions.addAll(dataList.map(
      (e) {
        if (e['category_is_income'] == 1) {
          totalInflow.value += e['amount'] as double;
        } else {
          totalOutflow.value += e['amount'] as double;
        }

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

  Future<void> fetchAndSetAuto() {
    final TabBarController tabbarController = Get.find();
    final TransactionController transactionController = Get.find();
    final dateRange = tabbarController.currentSelectedMonthRange;
    return transactionController.fetchAndSet(
      startDate: dateRange[0],
      endDate: dateRange[1],
    );
  }

  void add(TransactionModel transaction) {
    transactions.add(transaction);
  }
}
