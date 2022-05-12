import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/transaction.dart';
import 'package:mof/theme/colors.dart';

class TransactionScreen extends GetView<TransactionController> {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchAndSet(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Obx(
          () => Container(
            color: CustomColor.background,
            child: ListView.builder(
              itemCount: controller.transactions.length,
              itemBuilder: (context, index) {
                final transaction = controller.transactions[index];
                return ListTile(
                  title: Text(
                    transaction.categoryName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: transaction.iconId != null
                      ? Icon(IconData(transaction.iconId as int))
                      : null,
                  trailing: Text(
                    "(${transaction.amount.toString()})",
                    style: TextStyle(
                      color: transaction.categoryIsIncome
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
