import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mof/controllers/new_transaction.dart';
import 'package:mof/models/category.dart';
import 'package:mof/models/wallet.dart';
import 'package:mof/ui/category_list.dart';
import 'package:mof/ui/wallet.dart';

class NewTransactionScreen extends GetView<NewTransactionController> {
  static const routeName = '/new-transaction';

  const NewTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Transaction'),
        actions: [
          TextButton(
            onPressed: () async {
              final success = await controller.onSubmit();
              if (success) {
                Get.back();
              }
            },
            child: const Text('SAVE'),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: controller.amountController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Amount",
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  controller.amount = double.parse(value as String);
                },
                validator: (value) {
                  if (value == null || value == "") return "Amount is required";
                  return controller.validateAmount(double.parse(value));
                },
              ),
              TextFormField(
                controller: controller.categoryController,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: "Select Category",
                  prefixIcon: Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    child: CircleAvatar(
                      child: controller.category != null
                          ? controller.category!.iconId != null
                              ? Icon(
                                  IconData(controller.category!.iconId as int),
                                )
                              : Text(
                                  controller.category!.name.substring(0, 1),
                                )
                          : const Text("?"),
                    ),
                  ),
                ),
                keyboardType: TextInputType.none,
                onTap: () async {
                  Get.focusScope!.unfocus();
                  final data = await Get.toNamed(CategoryList.routeName);
                  Get.focusScope!.unfocus();
                  if (data == null) return;
                  controller.category = data;
                  controller.categoryController.text =
                      (data as CategoryModel).name;
                },
                validator: (value) {
                  return controller.validateCategory(controller.category);
                },
              ),
              TextFormField(
                controller: controller.dateController,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: "Date",
                  prefixIcon: Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    child: const Icon(Icons.calendar_today),
                  ),
                ),
                keyboardType: TextInputType.none,
                onTap: () async {
                  final datetime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                  );

                  if (datetime == null) return;

                  controller.date = datetime;
                  controller.dateController.text =
                      DateFormat('dd/MMM/yyyy').format(datetime);
                },
                validator: (value) {
                  return controller.validateDate(controller.date);
                },
              ),
              TextFormField(
                  controller: controller.walletController,
                  keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: "Wallet",
                    prefixIcon: Container(
                      margin: const EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        child: controller.wallet != null
                            ? controller.wallet!.iconId != null
                                ? Icon(
                                    IconData(controller.wallet!.iconId as int),
                                  )
                                : Text(
                                    controller.wallet!.name.substring(0, 1),
                                  )
                            : const Text("?"),
                      ),
                    ),
                  ),
                  onTap: () async {
                    Get.focusScope!.unfocus();
                    final data = await Get.toNamed(WalletUI.routeName);
                    Get.focusScope!.unfocus();
                    if (data == null) return;

                    controller.wallet = data;
                    controller.walletController.text =
                        (data as WalletModel).name;
                  },
                  validator: (value) {
                    return controller.validateWallet(controller.wallet);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
