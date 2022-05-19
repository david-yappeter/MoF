import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mof/controllers/transaction.dart';
import 'package:mof/formatter/currency.dart';
import 'package:mof/theme/colors.dart';

class TransactionScreen extends GetView<TransactionController> {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchAndSetAuto(),
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
                      height: 90.0,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Inflow',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColor.textGray,
                                ),
                              ),
                              Text(
                                CurrencyFormatter.formatCurrency(
                                    controller.totalInflow.value),
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
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColor.textGray,
                                ),
                              ),
                              Text(
                                CurrencyFormatter.formatCurrency(
                                    controller.totalOutflow.value),
                                style: const TextStyle(
                                  color: CustomColor.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 2.0,
                            color: Colors.black,
                            indent: 150,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              CurrencyFormatter.formatCurrency(
                                  controller.totalInflow.value -
                                      controller.totalOutflow.value),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  child: Column(
                    children: const [
                      ListTile(
                        leading: Text("03"),
                        title: Text("Today"),
                        subtitle: Text('April 2022'),
                        trailing: Text("1.000.000"),
                      ),
                    ],
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
                        CurrencyFormatter.formatCurrency(transaction.amount),
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
