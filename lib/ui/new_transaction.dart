import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/new_transaction.dart';

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
            onPressed: () {},
            child: const Text('SAVE'),
          ),
        ],
        leading: const Icon(Icons.close),
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
                  controller.amount = value as double;
                },
                validator: (value) {
                  controller.validateAmount(value as double);
                },
              ),
              TextFormField(
                controller: controller.categoryController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Select Category",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
