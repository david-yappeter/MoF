import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mof/const/storage.dart';
import 'package:mof/controllers/category.dart';
import 'package:mof/controllers/wallet.dart';

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

  Future<bool> onSubmit() async {
    if (formKey.currentState!.validate()) {
      final WalletController walletController = Get.find();
      final CategoryController categoryController = Get.find();

      formKey.currentState!.save();

      await categoryController.insert(
        name: expenseCategoryName.value,
        iconId: null,
        createdAt: DateTime.now(),
        isIncome: 0,
      );
      final walletId = await walletController.insert(
          name: firstWalletName.value, amount: 0.0);

      // Select initial wallet
      GetStorage().write(SELECTED_WALLET, walletId);

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
