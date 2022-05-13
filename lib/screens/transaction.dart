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
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0),
                      width: double.infinity,
                      height: 50.0,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Inflow',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColor.textGray,
                                ),
                              ),
                              Text(
                                '${controller.totalInflow.value.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: CustomColor.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Outflow',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColor.textGray,
                                ),
                              ),
                              Text(
                                '${controller.totalOutflow.value.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: CustomColor.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
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
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
