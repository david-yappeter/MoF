import 'package:get/get.dart';

class PinController extends GetxController {
  var pin = ''.obs;

  append(String x) {
    pin.value += x;
  }

  clear() {
    pin.value = '';
  }
}
