import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/new_category.dart';
import 'package:mof/firebase/myAnalytics.dart';

class NewCategoryScreen extends GetView<NewCategoryController> {
  static const routeName = '/new-category';

  const NewCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyFirebaseAnalytics firebaseanalytics = MyFirebaseAnalytics();
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Category'),
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
                validator: (value) {
                  if (value == null || value == "") return "Name is required";
                  return controller.validateName(value);
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              Obx(
                () => InputDecorator(
                  decoration: InputDecoration(
                    label: const Text('Expense / Income'),
                    errorStyle: const TextStyle(
                        color: Colors.redAccent, fontSize: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  isEmpty: controller.isExpense.value == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.isExpense.value,
                      isDense: true,
                      onChanged: controller.handleExpenseChange,
                      items: const [
                        DropdownMenuItem<String>(
                          value: 'Expense',
                          child: Text('Expense'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Income',
                          child: Text('Income'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
