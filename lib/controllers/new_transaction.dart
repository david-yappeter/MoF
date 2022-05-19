import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/list_tile_wallet.dart';
import 'package:mof/controllers/wallet.dart';
// import 'package:mof/controllers/transaction.dart';
import 'package:mof/database/helper.dart';
import 'package:mof/models/category.dart';
// import 'package:mof/models/transaction.dart';
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

  @override
  void onInit() {
    super.onInit();

    amountController = TextEditingController();
    categoryController = TextEditingController();
    dateController = TextEditingController();
    walletController = TextEditingController();
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

  Future<bool> onSubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();

    final WalletController walletController = Get.find();
    final ListTileWalletController listTileWalletController = Get.find();
    final sqlDb = await DBHelper.database();
    // final id = await sqlDb.insert(DBHelper.transactionDBName, {
    await sqlDb.insert(DBHelper.transactionDBName, {
      'amount': amount,
      'category_id': category!.id,
      'wallet_id': wallet!.id,
      'created_at': date!.toIso8601String(),
      'updated_at': date!.toIso8601String(),
    });
    await walletController.updateAmount(
        walletId: wallet!.id,
        amount: category!.isIncome == 1 ? amount : amount * -1);

    listTileWalletController.reload();

    return true;
  }

  void validations(Map<String, Object> val) async {
    if (val['amount'] == null) {
      // inputs.put('amount', 0);
    }
  }
}
