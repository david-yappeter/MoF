import 'package:get/get.dart';
import 'package:mof/controllers/custom_tab_bar.dart';
import 'package:mof/controllers/list_tile_wallet.dart';
import 'package:mof/database/helper.dart';
import 'package:mof/models/transaction.dart';

class TransactionController extends GetxController {
  RxList<dynamic> transactions = [].obs;
  RxMap<String, List<TransactionModel>> groupedTransaction =
      <String, List<TransactionModel>>{}.obs;
  RxMap<String, Map<String, double>> groupedTransactionByCategory =
      <String, Map<String, double>>{
    'income': {},
    'expense': {},
  }.obs;
  RxDouble totalInflow = 0.0.obs;
  RxDouble totalOutflow = 0.0.obs;
  RxDouble openingBalance = 0.0.obs;
  RxDouble endingBalance = 0.0.obs;

  Future<void> fetchAndSet(
      {DateTime? startDate, DateTime? endDate, int? walletId}) async {
    final whereFilter = [];
    final openingBalanceWhereFilter = [];

    if (startDate != null) {
      whereFilter.add('t.created_at >= date(\'${startDate.toString()}\')');
      openingBalanceWhereFilter
          .add(' t.created_at <= date(\'${startDate.toString()}\')');
    }
    if (endDate != null) {
      whereFilter.add(' t.created_at <= date(\'${endDate.toString()}\')');
    }

    if (walletId != null) {
      whereFilter.add(' t.wallet_id = $walletId');
      openingBalanceWhereFilter.add(' t.wallet_id = $walletId');
    }

    final dataList = await DBHelper.rawQuery(
      '''
        SELECT t.*, c.name as category_name, c.is_income as category_is_income 
        FROM ${DBHelper.transactionDBName} as t 
        INNER JOIN ${DBHelper.categoryDBName} as c 
        ON t.category_id = c.id
        ${whereFilter.isNotEmpty ? 'WHERE ' : ''}
        ${whereFilter.join(' AND ')}
        ORDER BY t.created_at DESC, t.id DESC
''',
    );

    final dataOpeningBalance = await DBHelper.rawQuery('''
      SELECT IFNULL(
        SUM(
        CASE
          WHEN c.is_income = 1 THEN t.amount ELSE -1 * t.amount
        END
        )
        , 0.0) as opening_balance FROM ${DBHelper.transactionDBName} as t
      INNER JOIN ${DBHelper.categoryDBName} as c
      ON t.category_id = c.id 
        ${openingBalanceWhereFilter.isNotEmpty ? 'WHERE ' : ''}
        ${openingBalanceWhereFilter.join(' AND ')}
    ''');

    final dataGroupedTransaction = await DBHelper.rawQuery('''
      SELECT c.name as category_name, c.is_income as category_is_income, SUM(amount) as total_amount
      FROM ${DBHelper.transactionDBName} as t 
      INNER JOIN ${DBHelper.categoryDBName} as c 
      ON t.category_id = c.id
      ${whereFilter.isNotEmpty ? 'WHERE ' : ''}
      ${whereFilter.join(' AND ')}
      GROUP BY category_name, category_is_income
    ''');

    openingBalance.value = dataOpeningBalance[0]['opening_balance'];
    endingBalance.value = dataOpeningBalance[0]['opening_balance'];

    transactions.clear();
    groupedTransaction.clear();
    totalInflow.value = 0.0;
    totalOutflow.value = 0.0;
    groupedTransactionByCategory['income']!.clear();
    groupedTransactionByCategory['expense']!.clear();

    void assignGroupedTransactionCategory(Map<String, dynamic> data) {
      final String categoryName = data['category_name'] as String;
      final bool categoryIsIncome = data['category_is_income'] == 1;
      final double totalAmount = data['total_amount'] as double;

      if (categoryIsIncome) {
        groupedTransactionByCategory['income']![categoryName] = totalAmount;
      } else {
        groupedTransactionByCategory['expense']![categoryName] = totalAmount;
      }
    }

    void fetchLoopFunc(Map<String, dynamic> e) {
      if (e['category_is_income'] == 1) {
        totalInflow.value += e['amount'] as double;
        endingBalance.value += e['amount'] as double;
      } else {
        totalOutflow.value += e['amount'] as double;
        endingBalance.value -= e['amount'] as double;
      }

      final transactionModel = TransactionModel(
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

      transactions.add(transactionModel);

      if (groupedTransaction[transactionModel.createdAt.toString()] == null) {
        groupedTransaction[transactionModel.createdAt.toString()] = [
          transactionModel
        ];
      } else {
        groupedTransaction[transactionModel.createdAt.toString()]
            ?.add(transactionModel);
      }
    }

    dataList.forEach(fetchLoopFunc);
    dataGroupedTransaction.toList().forEach(assignGroupedTransactionCategory);

    groupedTransactionByCategory.refresh();
  }

  Future<void> fetchAndSetAuto() {
    final TabBarController tabbarController = Get.find();
    final TransactionController transactionController = Get.find();
    final ListTileWalletController listTileWalletController = Get.find();
    final dateRange = tabbarController.currentSelectedMonthRange;
    final selectedWalletId = listTileWalletController.selectedWalletId;

    return transactionController.fetchAndSet(
      startDate: dateRange[0],
      endDate: dateRange[1],
      walletId: selectedWalletId,
    );
  }

  void add(TransactionModel transaction) {
    transactions.add(transaction);
  }

  // Future<void> updateAmount(
  //     {required int walletId, required double amount}) async {
  //   final sqlDb = await DBHelper.database();

  //   return sqlDb.execute('''
  //     UPDATE ${DBHelper.transactionDBName}
  //     SET amount = amount + $amount
  //     WHERE wallet_id = $walletId
  //   ''');
  // }
}
