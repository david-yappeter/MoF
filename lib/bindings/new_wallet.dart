import 'package:get/get.dart';
import 'package:mof/controllers/new_wallet.dart';

class NewWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewWalletController>(() => NewWalletController());
  }
}
