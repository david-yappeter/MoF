import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/category.dart';

class NewCategoryController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  Rx<String> isExpense = "Expense".obs;

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

  void handleExpenseChange(String? newVal) {
    isExpense.value = newVal as String;
  }

  String? validateExpense(String? value) {
    if (value == null) {
      return 'Expense is required';
    }
    return null;
  }

  Future<bool> onSubmit() async {
    final success = formKey.currentState!.validate();
    if (!success) {
      return false;
    }

    final categoryController = Get.find<CategoryController>();
    categoryController.insert(
      name: nameController.text,
      isIncome: isExpense.value == "Expense" ? 0 : 1,
      createdAt: DateTime.now(),
    );

    return true;
  }
}
