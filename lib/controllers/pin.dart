import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mof/const/storage.dart';
import 'package:mof/ui/home.dart';

class PinController extends GetxController {
  var pin = ''.obs;
  RxBool error = false.obs;

  append(int x) {
    if (pin.value.length >= 6) return;
    pin.value += x.toString();

    if (pin.value.length == 6) {
      final success = check();
      if (success) {
        error.value = false;
        Get.offAllNamed(Home.routeName);
      } else {
        error.value = true;
      }
    }
  }

  delete() {
    if (pin.value.isEmpty) return;
    pin.value = pin.value.substring(0, pin.value.length - 1);
  }

  clear() {
    pin.value = '';
  }

  bool check() {
    final userPin = GetStorage().read(USER_PIN);
    final success = userPin == pin.value;
    if (!success) clear();

    return success;
  }
}
