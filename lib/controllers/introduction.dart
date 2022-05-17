import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class IntroductionController extends GetxController {
  final PageController _pageController = PageController();
  final index = 0.obs;
  var formKey = GlobalKey<FormState>();
  RxString firstWalletName = ''.obs;
  RxString expenseCategoryName = ''.obs;
  TextEditingController firstWalletNameController = TextEditingController();
  TextEditingController expenseCategoryNameController = TextEditingController();

  void changeIndex(int val) {
    index.value = val;
  }

  String? validateWallet(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Wallet name is required';
    }
    return null;
  }

  String? validateCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Category name is required';
    }
    return null;
  }

  bool onSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }

  PageController get pageController => _pageController;

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }
}
