import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/new_wallet.dart';

class NewWalletScreen extends GetView<NewWalletController> {
  static const routeName = '/new-wallet';

  const NewWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Wallet'),
        actions: [
          TextButton(
            onPressed: () async {
              final success = await controller.onSubmit();
              if (success) {
                Get.back(result: success);
              }
            },
            child: const Text('SAVE'),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Get.back(result: null);
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
                controller: controller.nameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Name",
                ),
                keyboardType: TextInputType.text,
                // onSaved: (value) {
                //   controller.amount = double.parse(value as String);
                // },
                validator: (value) {
                  if (value == null || value == "") return "Name is required";
                  return controller.validateName(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
