import 'package:get/get.dart';
import 'package:mof/controllers/transaction.dart';

class FilterController extends GetxController {
  RxInt categoryId = 0.obs;

  void reset() {
    final TransactionController transactionController = Get.find();
    categoryId.value = 0;
    transactionController.fetchAndSetAuto();
  }

  void set(int categoryId) {
    final TransactionController transactionController = Get.find();
    this.categoryId.value = categoryId;
    transactionController.fetchAndSetAuto();
  }
}
