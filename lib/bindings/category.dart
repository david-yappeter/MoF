import 'package:get/get.dart';
import 'package:mof/controllers/category.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController());
  }
}
