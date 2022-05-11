import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/models/category.dart';
import 'package:mof/models/wallet.dart';

class NewTransactionController extends GetxController {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController amountController,
      categoryController,
      dateController,
      walletController;
  double amount = 0.0;
  CategoryModel? category;
  DateTime? date;
  WalletModel? wallet;

  GlobalKey<FormState> get formKey => _formKey;

  // final inputs = RxMap({
  //   'amount': RxDouble(0),
  //   'categoryId': RxnInt(null),
  // });

  @override
  void onInit() {
    super.onInit();

    amountController = TextEditingController();
    categoryController = TextEditingController();
    dateController = TextEditingController();
    walletController = TextEditingController();
    // debounce<Map<String, Object>>(inputs, validations,
    //     time: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    categoryController.dispose();
    dateController.dispose();
    walletController.dispose();
  }

  String? validateAmount(double? value) {
    if (value == null) {
      return "Amount is required";
    }
    if (value <= 0) {
      return 'Amount must be greater than 0';
    }
    return null;
  }

  String? validateCategory(CategoryModel? value) {
    if (value == null) {
      return 'Category must be selected';
    }
    return null;
  }

  String? validateDate(DateTime? value) {
    if (value == null) {
      return 'Date must be selected';
    }
    return null;
  }

  String? validateWallet(WalletModel? value) {
    if (value == null) {
      return 'Wallet must be selected';
    }
    return null;
  }

  void onSubmit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }

  void validations(Map<String, Object> val) async {
    if (val['amount'] == null) {
      // inputs.put('amount', 0);
    }
  }
}
