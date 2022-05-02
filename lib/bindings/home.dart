import 'package:get/get.dart';
import 'package:mof/router/custom_bottom_navigation.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavigationRouter());
  }
}
