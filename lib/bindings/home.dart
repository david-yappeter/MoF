import 'package:get/get.dart';
import 'package:mof/controllers/custom_tab_bar.dart';
import 'package:mof/router/custom_bottom_navigation.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavigationRouter());
    Get.lazyPut(() => TabBarController());
  }
}
