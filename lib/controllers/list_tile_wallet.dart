import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mof/const/storage.dart';

class ListTileWalletController extends GetxController {
  RxInt selectedWallet = ((GetStorage().read(SELECTED_WALLET) ?? 0) as int).obs;

  int get selectedWalletId => selectedWallet.value;

  void setSelectedWallet(int id) {
    GetStorage().write(SELECTED_WALLET, id);
    selectedWallet.value = id;
  }

  // Trigger Observer Reload Manually
  void reload() {
    selectedWallet.refresh();
  }
}
