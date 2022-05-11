import 'package:get/get.dart';
import 'package:mof/controllers/wallet.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletController>(() => WalletController());
  }
}
