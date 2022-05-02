import 'package:get/get.dart';
import 'package:mof/controllers/controller.dart';

class OtherBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller>(() => Controller());
  }
}
