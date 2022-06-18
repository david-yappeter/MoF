import 'package:get/get.dart';
import 'package:mof/controllers/new_category.dart';

class NewCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewCategoryController());
  }
}
