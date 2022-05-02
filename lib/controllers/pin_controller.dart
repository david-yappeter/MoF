import 'package:get/get.dart';

class PinController extends GetxController {
  var pin = ''.obs;

  append(int x) {
    pin.value += x.toString();
  }

  delete() {
    if (pin.value.isEmpty) return;
    pin.value = pin.value.substring(0, pin.value.length - 1);
  }

  clear() {
    pin.value = '';
  }
}
