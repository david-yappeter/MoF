import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTransactionController extends GetxController {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController,
      _categoryController,
      _dateController,
      _walletController;
  double amount = 0.0;
  int? categoryId;
  DateTime? date;
  int? walletId;

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get amountController => _amountController;
  TextEditingController get categoryController => _categoryController;
  TextEditingController get dateController => _dateController;
  TextEditingController get walletController => _walletController;

  // final inputs = RxMap({
  //   'amount': RxDouble(0),
  //   'categoryId': RxnInt(null),
  // });

  @override
  void onInit() {
    super.onInit();

    _amountController = TextEditingController();
    _categoryController = TextEditingController();
    _dateController = TextEditingController();
    _walletController = TextEditingController();
    // debounce<Map<String, Object>>(inputs, validations,
    //     time: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    _dateController.dispose();
    _walletController.dispose();
  }

  String? validateAmount(double value) {
    if (value <= 0) {
      return 'Amount must be greater than 0';
    }
    return null;
  }

  String? validateCategory(int? value) {
    if (value == null || value <= 0) {
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

  String? validateWallet(int? value) {
    if (value == null || value <= 0) {
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
