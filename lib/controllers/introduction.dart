import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class IntroductionController extends GetxController {
  final PageController _pageController = PageController();
  final index = 0.obs;
  var formKey = GlobalKey<FormState>();
  RxString firstWalletName = ''.obs;
  RxString expenseCategoryName = ''.obs;

  PageController get pageController => _pageController;

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }

  void changeIndex(int val) {
    index.value = val;
  }
}
