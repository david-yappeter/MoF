import 'package:get/get.dart';
import 'package:mof/controllers/new_transaction.dart';

class NewTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewTransactionController());
  }
}
