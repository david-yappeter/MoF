import 'package:get/get.dart';
import 'package:mof/controllers/set_pin.dart';

class SetPinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetPinController());
  }
}
