import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/wallet.dart';

class NewWalletController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  String? validateName(String? value) {
    if (value == null) {
      return 'Name is required';
    }
    return null;
  }

  Future<bool> onSubmit() async {
    if (formKey.currentState!.validate()) {
      final walletController = Get.find<WalletController>();
      // formKey.currentState!.save();
      await walletController.insert(
        name: nameController.text,
        amount: 0,
      );
      walletController.reload();
      return true;
    } else {
      return false;
    }
  }
}
