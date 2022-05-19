import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mof/const/storage.dart';

class SetPinController extends GetxController {
  RxBool successConfirmPin = (GetStorage().read(USER_PIN) == null).obs;
  RxBool error = false.obs;
  RxString currentPin = ''.obs;

  append(int x) {
    if (currentPin.value.length >= 6) return;
    currentPin.value += x.toString();
    if (successConfirmPin.value && currentPin.value.length == 6) {
      GetStorage().write(USER_PIN, currentPin.value);
      clear();
      Get.back();
    } else {
      final success = check();
      if (success) {
        // Confirm Pin
        successConfirmPin.value = true;
        clear();
      } else {
        error.value = true;
        if (currentPin.value.length == 6) {
          clear();
        }
      }
    }
  }

  delete() {
    if (currentPin.value.isEmpty) return;
    currentPin.value =
        currentPin.value.substring(0, currentPin.value.length - 1);
  }

  clear() {
    currentPin.value = '';
  }

  bool check() {
    final userPin = GetStorage().read(USER_PIN);
    final success = userPin == currentPin.value;

    return success;
  }
}
