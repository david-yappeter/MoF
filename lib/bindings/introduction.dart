import 'package:get/get.dart';
import 'package:mof/controllers/introduction.dart';

class IntroductionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IntroductionController());
  }
}
